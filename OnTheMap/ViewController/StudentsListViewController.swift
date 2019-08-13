//
//  StudentsListViewController.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class StudentsListViewController: BaseTabViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private lazy var dataSource: StudentsListDataSource = {
        return StudentsListDataSource(didSelect: { [weak self] studentLocation in
            
            guard let url = URL(string: studentLocation.mediaURL) else {
                
                self?.showAlert(Alerts.WrongUrlTitle, message: Alerts.WrongUrlMessage)
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
    }()
    
    // MARK: - Life cyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource.configure(tableView: tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dataSource.set(studentLocations: Students.locations)
    }
}

// MARK: - BaseTabViewControllerDelegate

extension StudentsListViewController: BaseTabViewControllerDelegate {
    
    func refreshStudentLocations() {
        
        dataSource.set(studentLocations: Students.locations)
        tableView.reloadData()
    }
}
