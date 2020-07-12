//
//  APIManager.swift
//  Jet2Competency
//
//  Created by Kritika Middha on 12/07/20.
//  Copyright © 2020 Ranosys. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

enum NetworkError: Error {
    case badRequest
}

class APIManager {
    
    static func callAPI(urlString: String, method: HTTPMethod = .get, params: [String:Any]?, callback: @escaping (Result<Any?, NetworkError>) -> Void) {
        
        //create the url object from string url
        guard  let url = URL(string: urlString) else {
            //if we are unable to create url object from strin url
            //call the callback and return the control
            callback(.failure(.badRequest))
            return
        }
        
        //create URLRequest object using the URL object
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let params = params {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    callback(.success(data))
                } else {
                    callback(.failure(.badRequest))
                }
            }
        })
        
        task.resume()
    }
}
