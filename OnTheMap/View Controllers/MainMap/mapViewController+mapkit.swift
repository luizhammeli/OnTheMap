//
//  mapViewController+mapkit.swift
//  OnTheMap
//
//  Created by Luiz Hammerli on 17/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController{
    
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
    
    func getPointAnnotation(){
        for location in SharedData.shared.studentsInformations{
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
