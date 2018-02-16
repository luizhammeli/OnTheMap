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
            
            //guard let json = json as? [String: Any] else {return}
            guard let response = response else {return}
            
            if(response.statusCode >= 200 && response.statusCode <= 299){
                completionHandler(true, nil)
            }else{
                completionHandler(false, nil)
            }
        }
    }
}
