//
//  AlertController.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 14/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class AlertController: UIViewController {
    
    class func showAlert(title: String?, message: String?, viewController: UIViewController, handler: ((UIAlertAction) -> Void)? = nil){
        
        var closeAlertAction = Strings.Dismiss
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        if let handler = handler{
            alert.addAction(UIAlertAction(title: Strings.Overwrite, style: UIAlertActionStyle.default, handler: handler))
            closeAlertAction = Strings.Cancel
        }
        
        alert.addAction(UIAlertAction(title: closeAlertAction, style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
