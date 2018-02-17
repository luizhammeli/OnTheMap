//
//  User.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 16/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation

struct User{
    
    let id: String
    let sessionID: String
    
    init(session: [String: Any], account: [String: Any]) {
        id = account["key"] as? String ?? ""
        sessionID = session["id"] as? String ?? ""
    }
}
