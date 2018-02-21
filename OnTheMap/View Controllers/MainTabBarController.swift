//
//  MainTabBarController.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 14/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    static let updateMapViewControllerNotificationName = NSNotification.Name(rawValue: "updateMapViewController")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logout(){
        ActivityIndicator.showActivityIndicator(viewController: self)
        UdacityClient.shared.udacityLogout { (success, error) in
            self.finishLogoutHandler(success, error)
        }
    }
    
    @IBAction func addLocation(_ sender: Any) {
        self.performSegue(withIdentifier: Strings.goToAddLocationSegueID, sender: self)
    }
    
    @IBAction func refreshMapViewController(_ sender: Any) {
        ActivityIndicator.showActivityIndicator(viewController: self)
        NotificationCenter.default.post(name: MainTabBarController.updateMapViewControllerNotificationName, object: nil)
    }
    
    func finishLogoutHandler(_ success: Bool, _ error: String?){
        DispatchQueue.main.async {
            ActivityIndicator.removeActivityIndicator()
            if(success){
                self.dismiss(animated: true, completion: nil)
            }else{
                guard let error = error else {return}
                AlertController.showAlert(title: "", message: error, viewController: self)
            }
        }
    }
    
    func goToUpdateLocation(alert: UIAlertAction){
        self.performSegue(withIdentifier: Strings.goToAddLocationSegueID, sender: self)
    }
}
