//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

struct StudentLocationsResponse: Codable {
    let results: [StudentLocation]
}

struct StudentLocation: Codable {
    
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectID: String
    let uniqueKey: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        
        case createdAt
        case firstName
        case lastName
        case latitude
        case longitude
        case mapString
        case mediaURL
        case objectID = "objectId"
        case uniqueKey
        case updatedAt
    }
}
