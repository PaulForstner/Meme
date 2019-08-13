//
//  CreateUserResponse.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

struct CreateUserResponse: Codable {
    
    let createdAt: String
    let objectID: String
    
    enum CodingKeys: String, CodingKey {
        
        case createdAt
        case objectID = "objectId"
    }
}
