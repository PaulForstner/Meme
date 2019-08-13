//
//  PrimaryTextField.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class PrimaryTextField: UITextField {
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 4
    }
}
