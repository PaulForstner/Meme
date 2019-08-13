//
//  TextFieldDelegate.swift
//  OnTheMap
//
//  Created by Paul Forstner on 29.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
