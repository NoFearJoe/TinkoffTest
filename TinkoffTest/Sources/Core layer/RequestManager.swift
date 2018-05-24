//
//  RequestManager.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation


enum RequestManagerError: Error {
    case invalidPath
}

enum RequestType {
    case get
    case post
}

final class RequestManager {

    func request(path: String, type: RequestType = .get, parameters: [String: Any]? = nil, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: path) else {
            completion(nil, RequestManagerError.invalidPath)
            return
        }
        
        var request: URLRequest!
        switch type {
        case .get:
            request = buildGetRequest(url: url, parameters: parameters)
        case .post:
            request = buildPostRequest(url: url, parameters: parameters)
        }
        
        URLSession
            .shared
            .dataTask(with: request) { completion($0, $2) }
            .resume()
    }
    
    
    fileprivate func buildPostRequest(url: URL, parameters: [String: Any]?) -> URLRequest {
        return buildRequest(url: url) { request in
            if let parameters = parameters {
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters,
                                                               options: .prettyPrinted)
            }
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
    }
    
    fileprivate func buildGetRequest(url: URL, parameters: [String: Any]?) -> URLRequest {
        return buildRequest(url: url, buildBlock: { request in
            var newUrl = url.absoluteString
            
            if let parameters = parameters {
                newUrl += "?" + parameters.map { element in
                    return "\(element.key)=\(element.value)"
                }.joined(separator: "&")
            }
            
            request.url = URL(string: newUrl)
            request.httpMethod = "GET"
        })
    }
    
    fileprivate func buildRequest(url: URL, buildBlock: (inout URLRequest) -> Void) -> URLRequest {
        var request = URLRequest(url: url)
        
        buildBlock(&request)
        
        return request
    }

}
