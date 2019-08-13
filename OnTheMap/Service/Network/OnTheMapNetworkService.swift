//
//  OnTheMapNetworkService.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class OnTheMapNetworkService: NSObject {
    
    struct Auth {
        static var sessionID: String?
    }
    
    struct Account {
    
        static var key: String?
        static var objectID: String?
        static var user: User?
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        
        let router = OnTheMapEndpointRouter.sessionID(username: username, password: password)
        _ = NetworkService.request(router: router, responseType: AccountSessionResponse.self, trimData: true) { (result, error) in
            
            if let result = result {
                
                Auth.sessionID = result.session.id
                Account.key = result.account.key
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func logout(completion: @escaping (Bool, Error?) -> Void) {
        
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        
        let router = OnTheMapEndpointRouter.logout(token: xsrfCookie?.value ?? "")
        _ = NetworkService.request(router: router, responseType: LogOutResponse.self, trimData: true) { (result, error) in
            
            if result != nil {
                
                Auth.sessionID = nil
                Account.key = nil
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func getUserData(completion: @escaping (UserResponse?, Error?) -> Void) {
        
        guard let accountKey = Account.key else {
            return
        }
        
        let router = OnTheMapEndpointRouter.getUserData(userID: accountKey)
        _ = NetworkService.request(router: router, responseType: UserResponse.self, trimData: true) { (result, error) in
            
            
            completion(result, error)
        }
    }
    
    class func getStudendLocations(limit: Int = 100, skip: Int = 0, order: String = "-updatedAt", completion: @escaping ([StudentLocation], Error?) -> Void) {
        
        let router = OnTheMapEndpointRouter.getStudendLocations(limit: limit, skip: skip, order: order)
        _ = NetworkService.request(router: router, responseType: StudentLocationsResponse.self) { (result, error) in
            
            if let result = result {
                completion(result.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func createStudentLocation(user: User, completion: @escaping (Bool, Error?) -> Void) {
        
        let router = OnTheMapEndpointRouter.createStudentLocation(user: user)
        _ = NetworkService.request(router: router, responseType: CreateUserResponse.self) { (result, error) in
            
            if result != nil {
                
                Account.objectID = result?.objectID
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func updateStudentLocation(user: User, objectID: String, completion: @escaping (Bool, Error?) -> Void) {
        
        let router = OnTheMapEndpointRouter.updateStudentLocation(user: user, objectID: objectID)
        _ = NetworkService.request(router: router, responseType: UpdateUserResponse.self) { (result, error) in
            
            if result != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
}
