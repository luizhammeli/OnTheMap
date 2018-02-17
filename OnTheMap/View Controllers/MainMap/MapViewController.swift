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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: MainTabBarController.updateMapViewControllerNotificationName, object: nil)
        mapView.delegate = self
    }
    
    @objc func refreshData(){
        AlertController.showAlert(title: "", message: "teste", viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showActivityIndicator(false)
        UdacityClient.shared.getMapsData { (success, error) in
            DispatchQueue.main.async {
                self.showActivityIndicator(true)
                self.getPointAnnotation()
            }
        }
    }
    
    func showActivityIndicator(_ hidden: Bool){
        visualEffectView.isHidden = hidden
        activityIndicator.isHidden = hidden
        hidden ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
    }
    
    func getPointAnnotation(){
        guard let locations = UdacityClient.shared.locations else {return}
        
        for location in locations{
            let latitude = CLLocationDegrees(location.latitude)
            let longitude = CLLocationDegrees(location.longitude)
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let firstName = location.firstName
            let lastNAme = location.lastName
            let mediaURL = location.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(firstName) \(lastNAme)"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        
        self.mapView.addAnnotations(annotations)
    }
}
