//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 14/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var annotations = [MKPointAnnotation]()
    
    static let updateTableViewControllerNotificationName = NSNotification.Name(rawValue: "updateTableViewController")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: MainTabBarController.updateMapViewControllerNotificationName, object: nil)
        mapView.delegate = self
        ActivityIndicator.showActivityIndicator(viewController: self)
        refreshData()
    }
    
    @objc func refreshData(){
        UdacityClient.shared.getMapsData { (success, error) in
            DispatchQueue.main.async {
                ActivityIndicator.removeActivityIndicator()
                if(success){
                    self.getPointAnnotation()
                    NotificationCenter.default.post(name: MapViewController.updateTableViewControllerNotificationName, object: nil)
                }else{
                    AlertController.showAlert(title: "", message: error, viewController: self)
                }
            }
        }
    }
}
