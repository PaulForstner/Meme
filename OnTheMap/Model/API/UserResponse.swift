//
//  UserResponse.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
    
    let uniqueKey: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        
        case uniqueKey = "key"
        case firstName = "last_name"
        case lastName = "first_name"
    }
}
