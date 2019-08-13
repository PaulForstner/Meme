//
//  StudentsMapViewController.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit
import MapKit

class StudentsMapViewController: BaseTabViewController {

    // MARK: - IBOutlet
    
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: - Lazy
    
    private lazy var mapViewDelegate = MapViewDelegate()
    
    // MARK: - Life cyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = mapViewDelegate
        delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addAnnotations()
    }
    
    // MARK: - Priavate

    private func addAnnotations() {
        
        mapView.removeAnnotations(mapView.annotations)
        var annotations = [MKPointAnnotation]()
        
        for studentLocation in Students.locations {
            
            let lat = CLLocationDegrees(studentLocation.latitude)
            let long = CLLocationDegrees(studentLocation.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = studentLocation.firstName
            let last = studentLocation.lastName
            let mediaURL = studentLocation.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
    }
}

// MARK: - BaseTabViewControllerDelegate

extension StudentsMapViewController: BaseTabViewControllerDelegate {
    
    func refreshStudentLocations() {
        addAnnotations()
    }
}
