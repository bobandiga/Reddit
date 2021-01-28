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
    var currentPage: String?
    var dataSource: SafeArray<FeedPost> = SafeArray()

    private var isLoading: SafeType<Bool> = SafeType(false)
    
    func loadMore(_ completion: @escaping (Error?) -> Void) {
        guard isLoading.wrappedValue == false else {
            DispatchQueue.main.async {
                completion(FeedError.isLoading)
            }
            return
        }
        isLoading.wrappedValue = true
        feedService.fetchNext(after: currentPage) { [weak self] (result) in
            switch result {
            case .success(let r):
                guard let response = r else {
                    DispatchQueue.main.async {
                        completion(FeedError.response)
                    }
                    return
                }
                
                if let data = try? JSONDecoder().decode(TopResponse.self, from: response.data) {
                    self?.currentPage = data.after
                    self?.dataSource.append(data.posts)
                }
                
                DispatchQueue.main.async {
                    completion(nil)
                }
            case .failure(let erorr):
                DispatchQueue.main.async {
                    completion(erorr)
                }
            }
            self?.isLoading.wrappedValue = false
        }
    }
    
    func loadFirst(_ completion: @escaping (Error?) -> Void) {
        guard !isLoading.wrappedValue else {
            completion(FeedError.isLoading)
            return
        }
        isLoading.wrappedValue = true
        feedService.fetchFeed { [weak self] (result) in
            switch result {
            case .success(let r):
                guard let response = r else {
                    DispatchQueue.main.async {
                        completion(FeedError.response)
                    }
                    return
                }
                
                if let data = try? JSONDecoder().decode(TopResponse.self, from: response.data) {
                    self?.currentPage = data.after
                    self?.dataSource.set(data.posts)
                }
                
                DispatchQueue.main.async {
                    completion(nil)
                }
            case .failure(let erorr):
                DispatchQueue.main.async {
                    completion(erorr)
                }
            }
            self?.isLoading.wrappedValue = false
        }
    }
    
}
