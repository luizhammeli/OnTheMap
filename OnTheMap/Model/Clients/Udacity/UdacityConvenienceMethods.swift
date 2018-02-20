//
//  UdacityConvenienceMethods.swift
//  OnTheMap
//
//  Created by iOS Developer on 15/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

extension UdacityClient{
    
    func udacityDefaultLogin(_ email: String, _ password: String, completionHandler:  @escaping(_ success: Bool, _ error: String?)->Void){
        let jsonBody: String = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}"
        
        UdacityClient.shared.taskForPOSTMethod(UdacityConstants.Session, parameters: [:], jsonBody: jsonBody) { (json, response, error) in
            if let error = error{
                if let errorMessage = error.userInfo[NSLocalizedDescriptionKey] as? String{
                    completionHandler(false, errorMessage)
                }
                completionHandler(false, Strings.LoginErrorDefaultMessage)
            }
            
            guard let json = json as? [String: Any] else {return}
            guard let response = response else {return}
            
            if (response.statusCode >= 200 && response.statusCode <= 299){
                guard let account = json[UdacityResponseKeysConstants.Account] as? [String: Any], let success = account[UdacityResponseKeysConstants.Registered] as? Bool else {return}
                guard let session = json[UdacityResponseKeysConstants.Session] as? [String: Any] else {return}
                
                UdacityClient.shared.user = User(session: session, account: account)
                
                completionHandler(success, nil)
            }else{
                guard let error = json[UdacityResponseKeysConstants.Error] as? String else {return}
                completionHandler(false, error)
            }
        }
    }
    
    func udacityLogout(completionHandler:  @escaping(_ success: Bool, _ error: String?)->Void){
        UdacityClient.shared.taskForDeleteMethod(UdacityConstants.Session) { (json, response, error) in
            
            if let errorMessage = error?.userInfo[NSLocalizedDescriptionKey] as? String{
                completionHandler(false, errorMessage)
            }
            
            guard let response = response else {return}
            
            if(response.statusCode >= 200 && response.statusCode <= 299){
                completionHandler(true, nil)
            }else{
                completionHandler(false, nil)
            }
        }
    }
    
    func getMapsData(completionHandler: @escaping (_ success: Bool, _ error: String?)->Void ){
        
        let queryParameter = ["limit":"100"]
        UdacityClient.shared.taskForGETTMethod(UdacityConstants.ParseApiGetStudentsMethod, queryParameters: queryParameter) { (json, response, error) in
            
            if let errorMessage = error?.userInfo[NSLocalizedDescriptionKey] as? String{
                completionHandler(false, errorMessage)
                return
            }
            
            guard let response = response,  let json = json as? [String: Any], let results = json["results"] as? [[String: Any]] else {completionHandler(false, "Error to get data"); return}
            
            if(response.statusCode >= 200 && response.statusCode <= 299){
                UdacityClient.shared.studentInformations = self.getLocationsArray(results)                
                completionHandler(true, nil)
            }else{
                completionHandler(false, nil)
            }
        }
    }
    
    func getUserData(completionHandler: @escaping (_ success: Bool, _ error: String?)->Void){
        guard let userID = UdacityClient.shared.user?.id else {return}
        UdacityClient.shared.taskForGETTMethod("\(UdacityConstants.GetUserData)\(userID)", stringHost: UdacityConstants.ApiHost) { (json, response, error) in
            
            if let errorMessage = error?.userInfo[NSLocalizedDescriptionKey] as? String{
                completionHandler(false, errorMessage)
            }
            
            guard let response = response,  let json = json as? [String: Any], let user = json["user"] as? [String: Any] else {completionHandler(false, Strings.ErrorGetUserData); return}
            
            if(response.statusCode >= 200 && response.statusCode <= 299){
                UdacityClient.shared.user?.name = user["nickname"] as! String
                completionHandler(true, nil)
            }else{
                completionHandler(false, nil)
            }
        }
    }
    
    func postLocationData(_ locationData: StudentInformation, mapString:String, completionHandler:  @escaping(_ success: Bool, _ error: String?)->Void){
        
        let jsonBody = "{\"uniqueKey\": \"\(locationData.uniqueKey)\", \"firstName\": \"\(locationData.firstName)\", \"lastName\": \"\(locationData.lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(locationData.mediaURL)\",\"latitude\": \(locationData.latitude), \"longitude\": \(locationData.longitude)}"
        
        let parameters = [UdacityConstants.ParseIDHeaderField: UdacityConstants.ParseApiID, UdacityConstants.ParseAPIKeyHeaderField: UdacityConstants.ParseAPIKey] as [String : AnyObject]
        
        UdacityClient.shared.taskForPOSTMethod(UdacityConstants.ParseApiGetStudentsMethod, parameters: parameters, jsonBody: jsonBody, host: UdacityConstants.ParseApiHost) { (json, response, error) in
            
            if let errorMessage = error?.userInfo[NSLocalizedDescriptionKey] as? String{
                completionHandler(false, errorMessage)
            }
            
            guard let response = response,  let json = json as? [String: Any], let _ = json["objectId"] as? String else {completionHandler(false, "Error to post user data"); return}
            
            if(response.statusCode >= 200 && response.statusCode <= 299){
                completionHandler(true, nil)
            }else{
                completionHandler(false, nil)
            }
        }
    }
    
    func getLocationsArray(_ locationDic: [[String: Any]])-> [StudentInformation]{
        var locations = [StudentInformation]()
        for location in locationDic{
            locations.append(StudentInformation(location))
        }
        return locations
    }
}
