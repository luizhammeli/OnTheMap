//
//  FinishAddLocationViewController.swift
//  OnTheMap
//
//  Created by iOS Developer on 15/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import MapKit

class FinishAddLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews(){
        finishButton.layer.cornerRadius = 6
    }
    
    @IBAction func finishAddLocation(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(name: MainTabBarController.updateMapViewControllerNotificationName, object: nil)
    }
    
    @IBAction func goToAddLocationViewController(){
        self.navigationController?.popViewController(animated: true)
    }
}
