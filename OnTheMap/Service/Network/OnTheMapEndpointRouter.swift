//
//  OnTheMapEndpointRouter.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

enum OnTheMapEndpointRouter: EndpointRouter {
    
    case sessionID(username: String, password: String)
    case logout(token: String)
    case getUserData(userID: String)
    case getStudendLocations(limit: Int, skip: Int, order: String)
    case createStudentLocation(user: User)
    case updateStudentLocation(user: User, objectID: String)
    
    var baseURL: String{
        return Constants.baseURL
    }
    
    var method: HTTPMethodType{
        
        switch self {
            
        case .sessionID:                return .post
        case .logout:                   return .delete
        case .getUserData:              return .get
        case .getStudendLocations:      return .get
        case .createStudentLocation:    return .post
        case .updateStudentLocation:    return .put
        }
    }
    
    var path: String{
        
        switch self {
        
        case .sessionID:                                return "session"
        case .logout:                                   return "session"
        case .getUserData(let userID):                  return "users/\(userID)"
        case .getStudendLocations:                      return "StudentLocation"
        case .createStudentLocation:                    return "StudentLocation"
        case .updateStudentLocation(_, let objectID):   return "StudentLocation/\(objectID)"
        }
    }
    
    var parameters: [String : String]? {
        
        switch self {
            
        case .sessionID:                        return nil
        case .logout:                           return nil
        case .getUserData:                      return nil
        case .getStudendLocations(let limit,
                                  let skip,
                                  let order):   return ["limit": "\(limit)", "skip": "\(skip)", "order": order]
        case .createStudentLocation:            return nil
        case .updateStudentLocation:            return nil
        }
    }
    
    var httpHeaders: [String : String]? {
        
        switch self {
        
        case .sessionID:                return ["Accept": "application/json",
                                                "Content-Type": "application/json"]
        case .logout(let token):        return ["X-XSRF-TOKEN": token]
        case .getUserData:              return nil
        case .getStudendLocations:      return nil
        case .createStudentLocation:    return ["Content-Type": "application/json"]
        case .updateStudentLocation:    return ["Content-Type": "application/json"]
        }
    }
    
    var bodyParameters: [String : Any]? {
        
        switch self {
            
        case .sessionID(let username, let password):    return ["udacity": ["username": username,
                                                                            "password": password]]
        case .logout:                                   return nil
        case .getUserData:                              return nil
        case .getStudendLocations:                      return nil
        case .createStudentLocation(let user):          return user.toDictionary()
        case .updateStudentLocation(let user, _):       return user.toDictionary()
        }
    }
}
