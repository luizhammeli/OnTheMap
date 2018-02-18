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
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var annotations = [MKPointAnnotation]()
    
    static let updateTableViewControllerNotificationName = NSNotification.Name(rawValue: "updateTableViewController")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: MainTabBarController.updateMapViewControllerNotificationName, object: nil)
        mapView.delegate = self
    }
    
    @objc func refreshData(){
        self.showActivityIndicator(false)
        UdacityClient.shared.getMapsData { (success, error) in
            DispatchQueue.main.async {
                self.showActivityIndicator(true)
                self.getPointAnnotation()                
                NotificationCenter.default.post(name: MapViewController.updateTableViewControllerNotificationName, object: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    func showActivityIndicator(_ hidden: Bool){
        visualEffectView.isHidden = hidden
        activityIndicator.isHidden = hidden
        hidden ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
    }
}
