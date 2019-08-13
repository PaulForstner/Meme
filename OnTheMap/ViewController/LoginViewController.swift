//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var userNameTextField: PrimaryTextField!
    @IBOutlet private weak var passwordTextField: PrimaryTextField!
    @IBOutlet private weak var loginButton: PrimaryButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var infoLabel: UILabel!
    
    // MARK: - Lazy
    
    private lazy var textFieldDelegate = TextFieldDelegate()
    
    // MARK: - Life cyle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupUI()
    }

    // MARK: - SetupUI
    
    private func setupUI() {
        
        // TextField
        userNameTextField.placeholder       = "Email"
        userNameTextField.delegate          = textFieldDelegate
        passwordTextField.placeholder       = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate          = textFieldDelegate
        
        // Button
        loginButton.setTitle("Log In", for: .normal)
        loginButton.isEnabled = false
        registerButton.setTitle("Sign Up", for: .normal)
        registerButton.tintColor = UIColor.primaryLight
        
        // Label
        infoLabel.text = "Don't have an account?"
    }
    
    // MARK: - IBActions
    
    @IBAction func loginAction(_ sender: Any) {
        
        guard let username = userNameTextField.text, let password = passwordTextField.text else {
            return
        }
        
        guard let loadingView = LoadingView.loadFromNib(with: "LoadingView") else {
            return
        }
        loadingView.frame = view.bounds
        view.addSubview(loadingView)
        
        OnTheMapNetworkService.login(username: username, password: password) { [weak self] (success, error) in
            
            if success {
                
                guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.tabBar) else {
                    
                    loadingView.removeFromSuperview()
                    return
                }
                self?.loadStutendLocations(completion: { success in
                    
                    loadingView.removeFromSuperview()
                    guard success else {
                        return
                    }
                    UIApplication.shared.keyWindow?.rootViewController = vc
                })
            } else {
                self?.showAlert(Alerts.WrongInputTitle, message: error?.localizedDescription ?? "")
                loadingView.removeFromSuperview()
            }
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        
        guard let udacityURl = URL(string: "https://auth.udacity.com/sign-up?next=https%3A%2F%2Fclassroom.udacity.com%2Fauthenticated") else {
            
            showAlert(Alerts.WrongUrlTitle, message: Alerts.WrongUrlMessage)
            return
        }
        
        UIApplication.shared.open(udacityURl, options: [:], completionHandler: nil)
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        
        let usernameFilled = userNameTextField.text != ""
        let passwordFilled = passwordTextField.text != ""
        loginButton.isEnabled = usernameFilled && passwordFilled
    }
    
    // MARK: - Private
    
    private func loadStutendLocations(completion: @escaping (Bool) -> Void) {
        
        OnTheMapNetworkService.getStudendLocations() { [weak self] (studentLocations, error) in
            
            if studentLocations.count > 0 {
                Students.locations = studentLocations
                completion(true)
            } else {
                self?.showAlert(Alerts.ErrorTitle, message: error?.localizedDescription ?? "")
                completion(false)
            }
        }
    }
}
