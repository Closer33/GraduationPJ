//
//  QPServerHandler.swift
//  QPServer
//
//  Created by Mac on 2019/4/22.
//

import PerfectLib
import PerfectWebSockets
import PerfectHTTP
import PerfectMongoDB

func makeRoutes() -> Routes {
    
    var routes = Routes()
    
    routes.add(method: .get, uri: "api/v1/oauth") { (request, response) in

        guard let openId = request.param(name: "openid") else {
            return
        }
        let client = try! MongoClient(uri: "mongodb://localhost")
        let db = client.getDatabase(name: "qupao")
        guard let collection = db.getCollection(name: "userInfo") else {
            return
        }
        defer {
            collection.close()
            db.close()
            client.close()
        }
        let dic = [   "openid": openId,
                    "nickname": request.param(name: "nickname"),
                   "figureurl": request.param(name: "figureurl")]
        let jsonStr = try! dic.jsonEncodedString()
        let bson = try! BSON(json: jsonStr)
        defer {
            bson.close()
        }
        let cursor = collection.find(query: BSON(map: ["openid": openId]))
        if ((cursor?.next()) == nil) {
            collection.insert(document: bson)
        } else {
            collection.update(selector: BSON(map: ["openid": openId]), update: bson)
        }
        try! response.setBody(json: ["200": "OK"])
        response.completed(status: .ok)
    }
    
    return routes
}

