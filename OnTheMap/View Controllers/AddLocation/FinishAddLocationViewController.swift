//
//  FinishAddLocationViewController.swift
//  OnTheMap
//
//  Created by iOS Developer on 15/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FinishAddLocationViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: UIButton!
    var mediaUrl: String = ""
    var stringLocation: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let geoCoder = CLGeocoder()
        ActivityIndicator.showActivityIndicator(viewController: self)
        geoCoder.geocodeAddressString(stringLocation) { (placemarks, error) in
            ActivityIndicator.removeActivityIndicator()
            if let error = error{
                AlertController.showAlert(title: Strings.LocationNotFoundTitleMessage, message: error.localizedDescription, viewController: self, handler: { alert in self.navigationController?.popViewController(animated: true)})
            }
            guard let placemarks = placemarks, let location = placemarks.first?.location else {return}
            self.setAnnotation(location)
        }   
    }
    
    func setUpViews(){
        finishButton.layer.cornerRadius = 6
    }
    
    func setAnnotation(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = stringLocation
        self.mapView.addAnnotation(annotation)
        self.mapView.showAnnotations( self.mapView.annotations, animated: true)
    }
    
    @IBAction func finishAddLocation(_ sender: Any) {
        guard let user = UdacityClient.shared.user else {return}
        let location = StudentInformation([JsonObjectKeys.FirstName: user.name, JsonObjectKeys.LastName: "", JsonObjectKeys.Latitude: self.mapView.annotations[0].coordinate.latitude, JsonObjectKeys.Longitude: self.mapView.annotations[0].coordinate.longitude, JsonObjectKeys.MediaURL: mediaUrl, JsonObjectKeys.UniqueKey: user.id])
        
        ActivityIndicator.showActivityIndicator(viewController: self)
        
        UdacityClient.shared.postLocationData(location, mapString: stringLocation) { (success, error) in
            self.postLocationCompletionHandler(success, error)
        }
    }
    
    func postLocationCompletionHandler(_ success: Bool, _ error: String?){
        DispatchQueue.main.async {
            ActivityIndicator.removeActivityIndicator()
            if(success){
                self.goToRootViewController()
                return
            }else{
                guard let error = error else {return}
                AlertController.showAlert(title: "", message: error, viewController: self)
            }
        }
    }
    
    func goToRootViewController(){
        self.navigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(name: MainTabBarController.updateMapViewControllerNotificationName, object: nil)
    }
    
    @IBAction func goToAddLocationViewController(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {        
        if control == view.rightCalloutAccessoryView {
            guard let subtitle = view.annotation?.subtitle else {return}
            if let stringUrl = subtitle{
                UIApplication.shared.showUrl(stringUrl: stringUrl)
            }
        }
    }
}
