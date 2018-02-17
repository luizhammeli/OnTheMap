//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by iOS Developer on 15/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class UdacityClient: NSObject {

    static let shared = UdacityClient()
    var user:User?
    var locations:[Location]?
    
    func taskForGETTMethod(_ method: String, completionHandlerForGET: @escaping (_ result: AnyObject?, _ response: HTTPURLResponse?, _ error: NSError?) -> Void){
        
        let request = NSMutableURLRequest(url: urlFromParameters([:], withPathExtension: method, host: UdacityConstants.ParseApiHost))
        request.httpMethod = UdacityConstants.GetMethod
        request.addValue(UdacityConstants.ParseApiID, forHTTPHeaderField: UdacityConstants.ParseIDHeaderField)
        request.addValue(UdacityConstants.ParseAPIKey, forHTTPHeaderField: UdacityConstants.ParseAPIKeyHeaderField)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { completionHandlerForGET(nil, nil, error as NSError?); return}
            
            if let error = error{
                completionHandlerForGET(nil, response, error as NSError)
            }
            
            guard let data = data else {return}
            
            //print(NSString(data: data, encoding: String.Encoding.utf8.rawValue))
            
            self.convertDataWithCompletionHandler(data, response, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        task.resume()
        
    }
    
    func taskForPOSTMethod(_ method: String, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ response: HTTPURLResponse?, _ error: NSError?) -> Void){
        
        let request = NSMutableURLRequest(url: urlFromParameters(parameters, withPathExtension: method))
        request.httpMethod = UdacityConstants.PostMethod
        request.addValue(UdacityConstants.JsonFormat, forHTTPHeaderField: UdacityConstants.Accept)
        request.addValue(UdacityConstants.JsonFormat, forHTTPHeaderField: UdacityConstants.ContentType)
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { completionHandlerForPOST(nil, nil, error as NSError?); return}
            
            if let error = error{
                completionHandlerForPOST(nil, response, error as NSError)
            }
            
            guard var data = data else {return}                        
            
            if(request.url?.absoluteString.contains(UdacityConstants.Session))!{
                data = self.convertLoginData(data)
            }
            
             self.convertDataWithCompletionHandler(data, response, completionHandlerForConvertData: completionHandlerForPOST)
        }
        
        task.resume()
    }
    
    func taskForDeleteMethod(_ method: String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ response: HTTPURLResponse?, _ error: NSError?) -> Void){
        
        let request = NSMutableURLRequest(url: urlFromParameters([:], withPathExtension: method))
        request.httpMethod = UdacityConstants.DeleteMethod
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { completionHandlerForPOST(nil, nil, error as NSError?); return}
            
            if let error = error{
                completionHandlerForPOST(nil, response, error as NSError)
            }
            
            guard var data = data else {return}
            
            if(request.url?.absoluteString.contains(UdacityConstants.Session))!{
                data = self.convertLoginData(data)
            }
            
            self.convertDataWithCompletionHandler(data, response, completionHandlerForConvertData: completionHandlerForPOST)
        }
        
        task.resume()
    }
    
    private func urlFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil, host: String?=nil) -> URL {
        var components = URLComponents()
        components.scheme = UdacityConstants.ApiScheme
        components.host = host == nil ? UdacityConstants.ApiHost : host
        components.path = withPathExtension ?? ""
        
        return components.url!
    }
    
    private func convertDataWithCompletionHandler(_ data: Data, _ response: HTTPURLResponse, completionHandlerForConvertData: (_ result: AnyObject?, _ response: HTTPURLResponse? ,_ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, response, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult, response, nil)
    }
    
    private func convertLoginData(_ data: Data) ->Data {
        let range = Range(5..<data.count)
        let newData = data.subdata(in: range)
        return newData
    }
}
