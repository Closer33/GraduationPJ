//
//  QPDataBaseManager.swift
//  COpenSSL
//
//  Created by Mac on 2019/4/23.
//

import PerfectMongoDB

func insertOrUpdateUserInfo(parameter: Dictionary<String, String>) -> Bool {
    
    let client = try! MongoClient(uri: "mongodb://localhost")
    let db = client.getDatabase(name: "qupao")
    
    guard let collection = db.getCollection(name: "userInfo") else {
        return false
    }
    
    defer {
        collection.close()
        db.close()
        client.close()
    }
    
    let jsonStr = try! parameter.jsonEncodedString()
    let bson = try! BSON(json: jsonStr)
    
    defer {
        bson.close()
    }
    
    let cursor = collection.find(query: BSON(map: ["openid": parameter["openid"]]))
    var result = MongoResult.success
    
    if ((cursor?.next()) == nil) {
        result = collection.insert(document: bson)
    } else {
        result = collection.update(selector: BSON(map: ["openid": ["openid": parameter["openid"]]]), update: bson)
    }
    
    switch result {
        case .success:
            return true
        case .error(_, _, _):
            return false
        default:
            return false
    }
}

func getUserInfo(openId: String) -> String {
    
    let client = try! MongoClient(uri: "mongodb://localhost")
    let db = client.getDatabase(name: "qupao")
    
    guard let collection = db.getCollection(name: "userInfo") else {
        return ""
    }
    
    defer {
        collection.close()
        db.close()
        client.close()
    }
    
    let cursor = collection.find(query: BSON(map: ["openid": openId]))
    if let resul = cursor?.next() {
        return resul.asString
    }
    return ""
}
