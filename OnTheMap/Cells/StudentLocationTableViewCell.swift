//
//  StudentLocationTableViewCell.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class StudentLocationTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var locationImageView: UIImageView!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        
        urlLabel.textColor          = .lightGray
        locationImageView.tintColor = UIColor.primaryLight
    }
    
    // MARK: - Configure
    
    func configure(with studentLocation: StudentLocation?) {
        
        nameLabel.text  = "\(studentLocation?.firstName ?? "") \(studentLocation?.lastName ?? "")"
        urlLabel.text   = studentLocation?.mediaURL
    }
}
