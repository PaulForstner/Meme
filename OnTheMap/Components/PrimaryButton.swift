//
//  PrimaryButton.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {

    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius  = 4
        backgroundColor     = UIColor.primaryLight
        tintColor           = .white
    }
}
