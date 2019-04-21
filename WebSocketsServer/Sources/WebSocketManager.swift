//
//  WebSocketManager.swift
//  WebSocketsServer
//
//  Created by yinquan on 2019/4/21.
//

import PerfectWebSockets

class WebSocketManager {

    static let sharedInstance = WebSocketManager ()
    
    private var socketDic = [String: Array<WebSocket>]()
    
    public func addSocket(socket: WebSocket, key: String) {
        
        if var socketArr = socketDic[key] {
            socketArr.append(socket)
            socketDic[key] = socketArr
            return;
        }
        
        var socketArr = Array<WebSocket>()
        socketArr.append(socket)
        socketDic[key] = socketArr
    }
    
    public func getAnotherSocket(socket: WebSocket, key: String) -> WebSocket? {
        
        if let socketArr = socketDic[key] {
            for anotherSocket in socketArr {
                if anotherSocket != socket {
                    return anotherSocket
                }
            }
        }
        
        return nil
    }
}
