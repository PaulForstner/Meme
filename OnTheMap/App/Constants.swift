//
//  Constants.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

struct Constants {
    
    static let baseURL = "https://onthemap-api.udacity.com/v1/"
    
    struct ViewControllerIdentifier {
        
        static let informationPosting = "InformationPostingViewController"
        static let loginView = "LoginViewController"
        static let tabBar = "TabBarController"
        static let loading = "LoadingViewController"
    }
    
    struct CellIdentifier {
        
        static let studentLocation = "StudentLocationTableViewCell"
    }
}

struct Alerts {
    
    static let DismissAlert = "Dismiss"
    static let ErrorTitle = "Error occured!"
    static let ErrorMessage = "Something went wrong please try again or restart the app."
    static let WrongInputTitle = "Wrong Input!"
    static let WrongInputMessage = "The input is wrong, please try again."
    static let WrongCredentialMessage = "The credentials are wrong, please try again."
    static let WrongUrlTitle = "Wrong URL!"
    static let WrongUrlMessage = "The url could not be opend."
    static let NoUrlMessage = "The input is no valid url."
    static let NoLocationFoundTitle = "No location found"
    static let NoLocationFoundMessage = "We could not find any location to your input, please try again."
    static let AddErrorMessage = "Could not add location."
    static let LogoutErrorTitle = "Could not log out."
}
