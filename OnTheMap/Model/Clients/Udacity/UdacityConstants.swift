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
    static let GetUserData = "/api/users/"
    static let Accept = "Accept"
    static let ContentType = "Content-Type"
    static let JsonFormat = "application/json"
    static let PostMethod = "POST"
    static let GetMethod = "GET"
    static let DeleteMethod = "DELETE"
    static let ParseIDHeaderField = "X-Parse-Application-Id"
    static let ParseAPIKeyHeaderField = "X-Parse-REST-API-Key"
    
    static let ParseApiID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let ParseAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    static let ParseApiHost = "parse.udacity.com"
    static let ParseApiGetStudentsMethod = "/parse/classes/StudentLocation"
}

struct UdacityResponseKeysConstants{
    static let Registered = "registered"
    static let Key = "key"
    static let ID = "id"
    static let Expiration = "expiration"
    static let Account = "account"
    static let Session = "session"
    static let Status = "status"
    static let Error = "error"
}

struct JsonObjectKeys{
    static let FirstName: String = "firstName"
    static let LastName: String = "lastName"
    static let Latitude: String = "latitude"
    static let Longitude: String = "longitude"
    static let MediaURL: String = "mediaURL"
    static let UniqueKey: String = "uniqueKey"
}
