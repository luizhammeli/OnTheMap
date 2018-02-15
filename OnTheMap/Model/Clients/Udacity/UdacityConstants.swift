//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by iOS Developer on 15/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation

struct UdacityConstants{
    static let ApiScheme = "https"
    static let ApiHost = "www.udacity.com"
    static let Session = "/api/session"
    static let Accept = "Accept"
    static let ContentType = "Content-Type"
    static let JsonFormat = "application/json"
    static let PostMethod = "POST"
    static let DeleteMethod = "DELETE"
}


struct UdacityResponseKeysConstants{
    static let Registered = "registered"
    static let Key = "key"
    static let ID = "id"
    static let Expiration = "expiration"
    static let Account = "account"
    static let Status = "status"
    static let Error = "error"
    
}
