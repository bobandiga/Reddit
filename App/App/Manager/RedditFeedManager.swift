//
//  RedditFeedManager.swift
//  App
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation
import Core
import CoreType

enum FeedError: String, Error {
    case isLoading
    case parse
    case response
}

final class RedditFeedManager: FeedManager {
    
    private lazy var feedService: NetworkService = FeedService()
    var currentPage: SafeType<String?> = SafeType(nil)
    var dataSource: SafeArray<FeedPost> = SafeArray()
    
    func loadMore(_ completion: @escaping (Error?) -> Void) {
        feedService.fetchNext(after: currentPage.wrappedValue) { [weak self] (result) in
            
            guard case let .success(r) = try? result, let response = r else {
                DispatchQueue.main.async { completion(FeedError.response) }
                return
            }
            guard let data = try? JSONDecoder().decode(TopResponse.self, from: response.data) else {
                DispatchQueue.main.async { completion(FeedError.parse) }
                return
            }
            
            self?.currentPage.wrappedValue = data.after
            self?.dataSource.append(data.posts)
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
    func loadFirst(_ completion: @escaping (Error?) -> Void) {
        feedService.fetchFeed { [weak self] (result) in
            
            guard case let .success(r) = try? result, let response = r else {
                DispatchQueue.main.async { completion(FeedError.response) }
                return
            }
            guard let data = try? JSONDecoder().decode(TopResponse.self, from: response.data) else {
                DispatchQueue.main.async { completion(FeedError.parse) }
                return
            }
            
            self?.currentPage.wrappedValue = data.after
            self?.dataSource.set(data.posts)
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
}
