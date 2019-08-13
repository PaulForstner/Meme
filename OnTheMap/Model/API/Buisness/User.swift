//
//  User.swift
//  OnTheMap
//
//  Created by Paul Forstner on 29.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

struct User {
    
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
}

extension User {
    
    func toDictionary() -> [String: Any] {
        
        return ["uniqueKey": uniqueKey,
                "firstName": firstName,
                "lastName": lastName,
                "mapString": mapString,
                "mediaURL": mediaURL,
                "latitude": latitude,
                "longitude": longitude]
    }
}
