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
    
    var selectedLocation: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logout(){
        UdacityClient.shared.udacityLogout { (success, error) in
            self.finishLogoutHandler(success, error)
        }
    }
    
    @IBAction func addLocation(_ sender: Any) {
        if (checkUserAddedLocation()){
            guard let location = self.selectedLocation else {return}
            let message = Strings.locationUpdateMessage.replacingOccurrences(of: "{user}", with: "\"\(location.firstName) \(location.lastName)\"")
            AlertController.showAlert(title: "", message: message, viewController: self, handler: goToUpdateLocation)
            return
        }
        self.performSegue(withIdentifier: Strings.goToAddLocationSegueID, sender: self)
    }
    
    @IBAction func refreshMapViewController(_ sender: Any) {
        NotificationCenter.default.post(name: MainTabBarController.updateMapViewControllerNotificationName, object: nil)
    }
    
    func finishLogoutHandler(_ success: Bool, _ error: String?){
        DispatchQueue.main.async {
            if(success){
                self.dismiss(animated: true, completion: nil)
            }else{
                guard let error = error else {return}
                AlertController.showAlert(title: "", message: error, viewController: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Strings.goToAddLocationSegueID){
            if let _ = selectedLocation{
                let _ = segue.destination as! AddLocationViewController
                print("update")
            }
        }
    }
    
    private func checkUserAddedLocation()->Bool{
        selectedLocation = nil
        
        for location in UdacityClient.shared.locations{
            if(UdacityClient.shared.user?.id == location.uniqueKey){
                self.selectedLocation = location
                return true
            }
        }
        return false
    }
    
    func goToUpdateLocation(alert: UIAlertAction){
        self.performSegue(withIdentifier: Strings.goToAddLocationSegueID, sender: self)
    }
}
