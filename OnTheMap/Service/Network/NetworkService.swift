//
//  NetworkService.swift
//  OnTheMap
//
//  Created by Paul Forstner on 28.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class NetworkService: NSObject {
    
    class func request<T: Decodable, U: EndpointRouter>(router: U, responseType: T.Type, trimData: Bool = false, completion: @escaping (T?, Error?) -> Void) -> URLSessionDataTask? {
        
        guard let urlRequest = router.urlRequest else {
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            var newData = data
            
            if trimData {
                
                let range = 5..<newData.count
                newData = newData.subdata(in: range)
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(T.self, from: newData) as? Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        
        task.resume()
        return task
    }
}
