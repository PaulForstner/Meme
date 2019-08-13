//
//  StudentsListDataSource.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class StudentsListDataSource: NSObject {
    
    // MARK: - Typealias
    
    typealias DidSelectHandler = (_ studentLocation: StudentLocation) -> Void
    
    // MARK: - Properties - Handler
    
    private var didSelectHandler: DidSelectHandler
    
    // MARK: - Properties
    
    private var studentLocations = [StudentLocation]()
    
    // MAKR: - Public
    
    func configure(tableView: UITableView) {
        
        tableView.register(UINib(nibName: Constants.CellIdentifier.studentLocation, bundle: nil), forCellReuseIdentifier: Constants.CellIdentifier.studentLocation)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func set(studentLocations: [StudentLocation]) {
        self.studentLocations = studentLocations
    }
    
    // MARK: - Initializer
    
    init(didSelect: @escaping DidSelectHandler) {
        didSelectHandler = didSelect
    }
}

// MARK: - UITableViewDataSource

extension StudentsListDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.studentLocation, for: indexPath) as? StudentLocationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: studentLocations.item(at: indexPath.row))
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension StudentsListDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let studentLocation = studentLocations.item(at: indexPath.row) else {
            return
        }
        didSelectHandler(studentLocation)
    }
}
