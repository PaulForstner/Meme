//
//  AccountSessionResponse.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

// MARK: - AccountSessionResponse

struct AccountSessionResponse: Codable {
    
    let account: AccountResponse
    let session: SessionResponse
}

// MARK: - SessionResponse

struct SessionResponse: Codable {
    let id: String
}

// MARK: - AccountResponse

struct AccountResponse: Codable {
    let key: String
}
