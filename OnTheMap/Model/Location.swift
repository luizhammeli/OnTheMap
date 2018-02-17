//
//  Location.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 16/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation

struct Location{
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mediaURL: String
    let uniqueKey: Int    
    
    init(_ dic: [String: Any]){
        firstName = dic[JsonObjectKeys.FirstName] as? String ?? ""
        print(firstName)
        lastName = dic[JsonObjectKeys.LastName] as? String ?? ""
        print(lastName)
        latitude = dic[JsonObjectKeys.Latitude] as? Double ?? 0.0
        longitude = dic[JsonObjectKeys.Longitude] as? Double ?? 0.0
        mediaURL = dic[JsonObjectKeys.MediaURL] as? String ?? ""
        uniqueKey = dic[JsonObjectKeys.UniqueKey] as? Int ?? 0                
    }
}



