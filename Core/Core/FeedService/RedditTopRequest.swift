//
//  RedditTopRequest.swift
//  Core
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation
import CoreNetwork

struct RedditTopRequest: Requestable {
    var method: CoreNetwork.Method = CoreNetwork.Method.get
    
    var endpoint: String = "/top.json"
    
    var parameters: Parameters = ["limit" : "10", "count" : "10"]
    
    var requestType: RequestType = .simple
    
    var timeout: TimeInterval = 10
    
    var cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad
    
    var headers: Headers = [:]
    
}
