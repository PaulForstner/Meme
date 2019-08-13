//
//  BaseTabViewController.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

protocol BaseTabViewControllerDelegate: class {
    func refreshStudentLocations()
}

class BaseTabViewController: UIViewController {

    // MARK: - Properties
    
    internal weak var delegate: BaseTabViewControllerDelegate?
    
    // MARK: - Lazy
    
    private lazy var logoutButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "LOGOUT", style: .plain, target: self, action: #selector(logout))
    }()
    
    private lazy var refreshButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "icon_refresh"), style: .plain, target: self, action: #selector(refresh))
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "icon_addpin"), style: .plain, target: self, action: #selector(add))
    }()
    
    // MARK: - Life cylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }

    // MARK: - SetupUI
    
    private func setupNavBar() {
        
        navigationItem.leftBarButtonItem     = logoutButton
        navigationItem.rightBarButtonItems   = [refreshButton, addButton]
        
        title = "On the Map"
    }
    
    // MARK: - Private
    
    @objc private func logout() {
        
        OnTheMapNetworkService.logout { [weak self] success, error in
            
            if success {
                
                guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.loginView) else {
                    return
                }
                UIApplication.shared.keyWindow?.rootViewController = vc
            } else {
                self?.showAlert(Alerts.LogoutErrorTitle, message: error?.localizedDescription ?? "")
            }
        }
    }
    
    @objc private func refresh() {
        
        OnTheMapNetworkService.getStudendLocations() { [weak self] (studentLocations, error) in
            
            if studentLocations.count > 0 {
                Students.locations = studentLocations
                self?.delegate?.refreshStudentLocations()
            } else {
                self?.showAlert(Alerts.ErrorTitle, message: error?.localizedDescription ?? "")
            }
        }
    }
    
    @objc private func add() {
        
        guard let loadingView = LoadingView.loadFromNib(with: "LoadingView") else {
            return
        }
        
        loadingView.frame = view.bounds
        view.addSubview(loadingView)
        
        if let user = OnTheMapNetworkService.Account.user {
            
            let userResponse = UserResponse(uniqueKey: user.uniqueKey, firstName: user.firstName, lastName: user.lastName)
            
            handle(userResponse, loadingView: loadingView)
        } else {
            
            OnTheMapNetworkService.getUserData { [weak self] userResponse, error in
                self?.handle(userResponse, loadingView: loadingView)
            }
        }
    }
    
    private func handle(_ userResponse: UserResponse?, loadingView: UIView? = nil) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.informationPosting) as? InformationPostingViewController else {
            return
        }
        
        loadingView?.removeFromSuperview()
        vc.userResponse = userResponse
        let navCon = UINavigationController(rootViewController: vc)
        self.present(navCon, animated: true, completion: nil)
    }
}
