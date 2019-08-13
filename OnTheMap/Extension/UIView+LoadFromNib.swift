//
//  UIView+LoadFromNib.swift
//  OnTheMap
//
//  Created by Paul Forstner on 29.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

extension UIView {
    
    class func loadFromNib(with identifier: String) -> UIView? {
        return Bundle.main.loadNibNamed(identifier, owner: nil, options: nil)?.first as? UIView
    }
}
