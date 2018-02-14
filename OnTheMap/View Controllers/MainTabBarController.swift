//
//  MainTabBarController.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 14/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    static let updateMapViewControllerNotificationName =  NSNotification.Name(rawValue: "updateMapViewController")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logout(){        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addLocation(_ sender: Any) {
        self.performSegue(withIdentifier: Strings.goToAddLocationSegueID, sender: self)
    }
    @IBAction func refreshMapViewController(_ sender: Any) {
        NotificationCenter.default.post(name: MainTabBarController.updateMapViewControllerNotificationName, object: nil)
    }
}
