//
//  FeedService.swift
//  Core
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation
import CoreNetwork

public typealias Callback = (Result<Response?, Error>) -> Void

public protocol NetworkService: class {
    
    var session: URLSession { get }
    func fetchFeed(_ completion: @escaping Callback)
    func fetchNext(after: String?, _ completion: @escaping Callback)
    
}

final public class FeedService: NetworkService {
    
    public var session: URLSession = .shared
    private lazy var network: Networkable = RedditNetwork()
    private lazy var cache: URLCache = URLCache.shared
    
    public init() {}
    
    public func fetchFeed(_ completion: @escaping Callback) {
        let topRequest = RedditTopRequest()
        guard let request = network.prepareForRequest(request: topRequest) else { return }
        
        if let response = cache.cachedResponse(for: request){
            completion(.success(Response.from(data: response.data, response: response.response)))
            return
        }
        
        let task = session.dataTask(with: request) { [weak self] (d, r, e) in
            if let error = e {
                completion(.failure(error))
                return
            }
            if let data = d, let response = r {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                self?.cache.storeCachedResponse(cachedResponse, for: request)
            }
            let response = Response.from(data: d, response: r)
            completion(.success(response))
        }
        
        task.resume()
    }
    
    public func fetchNext(after: String?, _ completion: @escaping Callback) {
        var moreRequest = RedditTopRequest()
        moreRequest.parameters["after"] = "\(after)"
        
        guard let request = network.prepareForRequest(request: moreRequest) else { return }
        
        if let response = cache.cachedResponse(for: request){
            completion(.success(Response.from(data: response.data, response: response.response)))
            return
        }
        
        let task = session.dataTask(with: request) { [weak self] (d, r, e) in
            if let error = e {
                completion(.failure(error))
                return
            }
            
            if let data = d, let response = r {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                self?.cache.storeCachedResponse(cachedResponse, for: request)
            }
            
            let response = Response.from(data: d, response: r)
            completion(.success(response))
        }
        task.resume()
    }
    
}

