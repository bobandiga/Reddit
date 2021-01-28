//
//  RedditNetwork.swift
//  Core
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation
import CoreNetwork

final class RedditNetwork: Networkable {
    
    lazy var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.reddit.com"
        return components
    }()
    var headers: Headers {
        return ["Content-Type": "application/json"]
    }
    
    func prepareForRequest(request: Requestable) -> URLRequest? {
        switch request.requestType {
        case .simple:
            return prepareSimpleRequest(request: request)
        case .upload(data: _):
            return nil
        case .download:
            return nil
        }
    }
    
}

private extension RedditNetwork {
    func prepareSimpleRequest(request: Requestable) -> URLRequest? {
        urlComponents.path = request.endpoint
        urlComponents.queryItems = request.parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = urlComponents.url else { return nil }
        
        print("URL: ",url)
        
        var urlRequest = URLRequest(url: url, cachePolicy: request.cachePolicy, timeoutInterval: request.timeout)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = request.method.rawValue
        
        request.headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        
        return urlRequest
    }
}


