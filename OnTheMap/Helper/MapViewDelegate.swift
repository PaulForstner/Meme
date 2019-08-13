//
//  MapViewDelegate.swift
//  OnTheMap
//
//  Created by Paul Forstner on 29.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import MapKit

class MapViewDelegate: NSObject, MKMapViewDelegate {
    
    private var showDetailDisclosure = true
    
    init(showDetailDisclosure: Bool = true) {
        self.showDetailDisclosure = showDetailDisclosure
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let urlString = view.annotation?.subtitle!, let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "PinAnnotation"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.pinTintColor = .red
            
            if showDetailDisclosure {
                pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
}
