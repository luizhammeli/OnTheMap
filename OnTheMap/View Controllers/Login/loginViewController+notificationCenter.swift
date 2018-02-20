//
//  loginViewController+notificationCenter.swift
//  OnTheMap
//
//  Created by iOS Developer on 20/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

extension LoginViewController{
    
    func addNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func showKeyboard(_ notification:Notification){
        self.view.frame.origin.y = -120
    }
    
    @objc func hideKeyboard(){
        self.view.frame.origin.y = 0
    }
}


