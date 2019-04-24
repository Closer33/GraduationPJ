//
//  QPServerHandler.swift
//  QPServer
//
//  Created by Mac on 2019/4/22.
//

import PerfectLib
import PerfectWebSockets
import PerfectHTTP
import Foundation

func makeRoutes() -> Routes {
    
    var routes = Routes()
    
    routes.add(method: .get, uri: "api/v1/oauth") { (request, response) in

        guard let openId = request.param(name: "openid") else {
            return
        }
        
        let dic = [   "openid": openId,
                      "nickname": request.param(name: "nickname")!,
                      "figureurl": request.param(name: "figureurl")!]
        
        let json = insertOrUpdateUserInfo(parameter: dic) ? ["result": "sucess"] : ["result": "error"];
        try! response.setBody(json: json)
        response.completed()
    }
    
    routes.add(method: .get, uri: "api/v1/websockt") { (request, response) in
        
        WebSocketHandler(handlerProducer: { (request: HTTPRequest, protocols: [String]) -> WebSocketSessionHandler? in
            
            let handle = QPWebSocketHandle()
            if protocols.first! == "create" {
                var roomId = ""
                repeat {
                    roomId = "\(arc4random_uniform(10))" + "\(arc4random_uniform(10))" + "\(arc4random_uniform(10))" + "\(arc4random_uniform(10))"
                } while QPWebSocketManager.shareInstance.isRoomExist(rommId: roomId)
                handle.roomId = roomId
            } else {
                handle.roomId = protocols[0];
            }
            handle.socketProtocol = protocols[1]
            
            return handle
        }).handleRequest(request: request, response: response)
    }
    
    return routes
}

class QPWebSocketHandle: WebSocketSessionHandler {
    
    var socketProtocol: String?
    
    var roomId: String?
    
    var isFirstEstablished = true
    
    var isLaunch = false
    
    func handleSession(request: HTTPRequest, socket: WebSocket) {
        
        guard let roomId = self.roomId else { return }
        
        guard let socketId = self.socketProtocol else { return }
        
        if isFirstEstablished {
            QPWebSocketManager.shareInstance.createOrJoinRoom(roomId: roomId, socket: socket, socketId: socketId)
            isFirstEstablished = false
        }
        
        socket.readStringMessage { (string, op, fin) in
            
            guard let string = string else {
                print("房间\(roomId)关闭")
                QPWebSocketManager.shareInstance.exitRoom(roomId: roomId)
                socket.close()
                return
            }
            
            if string == "create" {
                print("\(socketId)创建房间\(roomId)成功")
                let dic = ["code": 1, "result": ["msg": "wait for joining", "roomId": roomId]] as [String : Any];
                let string = try! dic.jsonEncodedString()
                socket.sendStringMessage(string: string, final: true, completion: {
                    self.handleSession(request: request, socket: socket)
                })
            }
            
            if string == "join" {
                if QPWebSocketManager.shareInstance.roomSocketCount(roomId: roomId) == 2 {
                    print("\(socketId)成功加入房间\(roomId)")
                    let room = QPWebSocketManager.shareInstance.getRoom(roomId: roomId)!
                    let firstSocket = QPWebSocketManager.shareInstance.getSocket(socketId: room[0])!;
                    let secondSocket = QPWebSocketManager.shareInstance.getSocket(socketId: room[1])!;
                    let joinString = "{\"code\": 2, \"result\": {\"roomId\": \(roomId), \"userInfos\": [\(getUserInfo(openId: room[0])), \(getUserInfo(openId: room[1]))]}}"
                    firstSocket.sendStringMessage(string: joinString, final: true, completion: {
                        self.handleSession(request: request, socket: socket)
                    })
                    secondSocket.sendStringMessage(string: joinString, final: true, completion: {
                        self.handleSession(request: request, socket: socket)
                    })
                    self.isLaunch = true
                } else {
                    print("房间\(roomId)关闭")
                    QPWebSocketManager.shareInstance.exitRoom(roomId: roomId)
                    socket.sendStringMessage(string: "{\"code\": 3, \"result\": \"roomId error\"}", final: true, completion: {
                        socket.close()
                    })
                }
            }
            
            if self.isLaunch {
                print("房间\(roomId)开始游戏")
                QPWebSocketManager.shareInstance.getAnotherSocket(roomId: roomId, socketId: socketId)?.sendStringMessage(string: "{\"type\": 003, \"result\": \(string)}", final: true, completion: {
                    self.handleSession(request: request, socket: socket)
                })
            }
        }
    }
}

class QPWebSocketManager {
    
    static let shareInstance = QPWebSocketManager()
    
    private var roomDic = [String: Array<String>]()
    
    private var socketDic = [String: WebSocket]()
    
    public func isRoomExist(rommId: String) -> Bool {
        
        if roomDic[rommId] == nil {
            return false
        }
        
        return true
    }
    
    public func createOrJoinRoom(roomId: String, socket: WebSocket, socketId: String) {
        
        socketDic[socketId] = socket;
        
        guard var room = roomDic[roomId] else {
            var newRoom = [String]()
            newRoom.append(socketId)
            roomDic[roomId] = newRoom
            return
        }
        
        room.append(socketId)
        roomDic[roomId] = room
    }
    
    public func exitRoom(roomId: String) {
    
        if isRoomExist(rommId: roomId) {
            for socketId in roomDic[roomId]! {
                socketDic[socketId] = nil
            }
            roomDic[roomId] = nil
        }
    }
    
    public func roomSocketCount(roomId: String) -> Int {
        
        guard let room = roomDic[roomId] else { return 0 }
        
        return room.count
    }
    
    public func getAnotherSocket(roomId: String, socketId: String) -> WebSocket? {
        
        guard let room = roomDic[roomId] else { return nil }
        
        for otherSocket in room {
            if otherSocket != socketId {
                return socketDic[socketId]
            }
        }
        
        return nil
    }
    
    public func getRoom(roomId: String) -> [String]? {
        
        return roomDic[roomId]
    }
    
    public func getSocket(socketId: String) -> WebSocket? {
        
        return socketDic[socketId]
    }
}
