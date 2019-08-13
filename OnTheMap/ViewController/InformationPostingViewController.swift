//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit
import MapKit

class InformationPostingViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var locationTextField: PrimaryTextField!
    @IBOutlet private weak var mediaURLTextField: PrimaryTextField!
    @IBOutlet private weak var findLocationButton: PrimaryButton!
    @IBOutlet private weak var finishButton: PrimaryButton!
    
    // MARK: - Lazy
    
    private lazy var cancelButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(dismissViewController))
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(named: "icon_back-arrow"), style: .plain, target: self, action: #selector(back))
        btn.title = "Find Location"
        return btn
    }()
    
    private lazy var mapView: MKMapView = {
        
        let mapView = MKMapView(frame: view.bounds)
        mapView.delegate = mapViewDelegate
        return mapView
    }()
    
    private lazy var mapViewDelegate = MapViewDelegate(showDetailDisclosure: false)
    private lazy var geocoder = CLGeocoder()
    private lazy var textFieldDelegate = TextFieldDelegate()
    
    // MARK: - Properties
    
    var userResponse: UserResponse?
    private var placemark: CLPlacemark?
    
    // MARK: - Life cyle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - SetupUI
    
    private func setupUI() {
        
        locationTextField.placeholder   = "Location"
        locationTextField.delegate      = textFieldDelegate
        locationTextField.text          = OnTheMapNetworkService.Account.user?.mapString
        mediaURLTextField.placeholder   = "Url"
        mediaURLTextField.delegate      = textFieldDelegate
        mediaURLTextField.text          = OnTheMapNetworkService.Account.user?.mapString
        
        findLocationButton.setTitle("Find Location", for: .normal)
        findLocationButton.isEnabled = false
        finishButton.setTitle("Finish", for: .normal)
        finishButton.isHidden = true
        
        setupNavBar()
    }
    
    private func setupNavBar() {

        navigationItem.leftBarButtonItem    = cancelButton
        title                               = "Add Location"
    }
    
    // MARK: - IBAction
    
    @IBAction func addLocationAction(_ sender: Any) {
        
        guard let location = locationTextField.text, let url = mediaURLTextField.text else {
            return
        }
        
        guard URL(string: url) != nil else {
            
            self.showAlert(Alerts.NoUrlMessage, message: Alerts.WrongUrlMessage)
            return
        }
        
        guard let loadingView = LoadingView.loadFromNib(with: "LoadingView") else {
            return
        }
        loadingView.frame = view.bounds
        view.addSubview(loadingView)
        
        geocoder.geocodeAddressString(location) { [weak self] (placeMarks, error) in
            
            if let placeMarks = placeMarks {
                self?.handle(placeMarks)
            } else {
                self?.showAlert(Alerts.NoLocationFoundTitle, message: Alerts.NoLocationFoundMessage)
            }
            loadingView.removeFromSuperview()
        }
    }
    
    @IBAction func finishAction(_ sender: Any) {
        
        
        guard let loadingView = LoadingView.loadFromNib(with: "LoadingView"),
            let userResponse = self.userResponse,
            let placemark = self.placemark,
            let mediaURL = mediaURLTextField.text,
            let coordinate = placemark.location?.coordinate,
            let key = OnTheMapNetworkService.Account.key else {
            
                showAlert(Alerts.ErrorTitle, message: Alerts.ErrorMessage)
                return
        }
        
        loadingView.frame = view.bounds
        view.addSubview(loadingView)
        
        let objectID = OnTheMapNetworkService.Account.objectID ?? ""
        let user = User(uniqueKey: key,
                                   firstName: userResponse.firstName,
                                   lastName: userResponse.lastName,
                                   mapString: placemark.name ?? "",
                                   mediaURL: mediaURL,
                                   latitude: coordinate.latitude,
                                   longitude: coordinate.longitude)
        
        OnTheMapNetworkService.Account.user = user
        
        if objectID == "" {
            OnTheMapNetworkService.createStudentLocation(user: user) { [weak self] (success, error) in
                self?.handle(success, error: error, loadingView: loadingView)
            }
        } else {
            OnTheMapNetworkService.updateStudentLocation(user: user, objectID: objectID) { [weak self] (success, error) in
                self?.handle(success, error: error, loadingView: loadingView)
            }
        }
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        
        let locationFilled = locationTextField.text != ""
        let mediaURLFilled = mediaURLTextField.text != ""
        findLocationButton.isEnabled = locationFilled && mediaURLFilled
    }
    
    // MARK: - Private
    
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func back() {
        
        hideViewMap(true)
    }

    private func handle(_ success: Bool, error: Error?, loadingView: UIView? = nil) {
        
        loadingView?.removeFromSuperview()
        if success {
            
            OnTheMapNetworkService.getStudendLocations() { [weak self] (studentLocations, error) in
                
                if studentLocations.count > 0 {
                    Students.locations = studentLocations
                }
                self?.dismissViewController()
            }
        } else {
            showAlert(Alerts.ErrorTitle, message: error?.localizedDescription ?? "")
        }
    }
    
    private func handle(_ placemarks: [CLPlacemark]) {
        
        guard let placemark = placemarks.first, let location = placemark.location else {
            return
        }
        
        self.placemark = placemark
        hideViewMap(false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = placemark.name
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
    }
    
    private func hideViewMap(_ hide: Bool) {
        
        mapView.isHidden = hide
        finishButton.isHidden = hide
        containerView.isHidden = !hide
        
        if mapView.isHidden {
            
            mapView.removeAnnotations(mapView.annotations)
            navigationItem.leftBarButtonItem = cancelButton
        } else {
            navigationItem.leftBarButtonItem = backButton
            guard mapView.superview == nil else {
                return
            }
            view.insertSubview(mapView, at: 0)
        }
    }
}
