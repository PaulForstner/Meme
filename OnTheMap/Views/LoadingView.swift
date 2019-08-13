//
//  LoadingView.swift
//  OnTheMap
//
//  Created by Paul Forstner on 29.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        activityIndicator.tintColor = .white
        activityIndicator.startAnimating()
    }
    
    deinit {
        activityIndicator.stopAnimating()
    }
}
