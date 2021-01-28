//
//  MockFeedManager.swift
//  App
//
//  Created by Максим Шаптала on 27.01.2021.
//

import Foundation

final class MockFeedManager: FeedManager {

    private var page: Int = 1
    
    var dataSource: [FeedPost] = [
        FeedPost(title: "Lorem ipsum dolor",
                 author: "Author1",
                 thumbPath: "https://static7.depositphotos.com/1314241/789/i/950/depositphotos_7890698-stock-photo-ferocious-lion.jpg",
                 comments: 1,
                 createdDate: "1 days ago"),
        FeedPost(title: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Salo ipsum dolor",
                 author: "Author2",
                 thumbPath: "https://static7.depositphotos.com/1314241/789/i/950/depositphotos_7890698-stock-photo-ferocious-lion.jpg",
                 comments: 2,
                 createdDate: "2 days age"),
        FeedPost(title: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor ", author: "Author3",
                 thumbPath: "https://static7.depositphotos.com/1314241/789/i/950/depositphotos_7890698-stock-photo-ferocious-lion.jpg",
                 comments: 0,
                 createdDate: "3 days age"),
        FeedPost(title: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor ", author: "Author4", thumbPath: nil, comments: 4, createdDate: "4 days age"),
        FeedPost(title: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor ", author: "Author5", thumbPath: nil, comments: 5, createdDate: "5 days age")
    ]
    
    func loadFirst(_ completion: @escaping () -> Void) {
        dataSource = [
            FeedPost(title: "Lorem ipsum dolor",
                     author: "Author1",
                     thumbPath: "https://static7.depositphotos.com/1314241/789/i/950/depositphotos_7890698-stock-photo-ferocious-lion.jpg",
                     comments: 1,
                     createdDate: "1 days ago"),
            FeedPost(title: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Salo ipsum dolor", author: "Author2", thumbPath: "nil", comments: 2, createdDate: "2 days age"),
            FeedPost(title: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor ", author: "Author3", thumbPath: nil, comments: 0, createdDate: "3 days age"),
            FeedPost(title: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor ", author: "Author4", thumbPath: nil, comments: 4, createdDate: "4 days age"),
            FeedPost(title: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor ", author: "Author5", thumbPath: nil, comments: 5, createdDate: "5 days age")
        ]
        
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func loadMore(_ completion: @escaping ([FeedPost]) -> Void) {
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 1) { [weak self] in
            
            let newDataSource = [
                FeedPost(title: "Lorem ipsum dolor",
                         author: "Author1",
                         thumbPath: "nil",
                         comments: 1,
                         createdDate: "1 days ago"),
                FeedPost(title: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Salo ipsum dolor", author: "Author2", thumbPath: "nil", comments: 2, createdDate: "2 days age"),
                FeedPost(title: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor ", author: "Author3", thumbPath: "https://static7.depositphotos.com/1314241/789/i/950/depositphotos_7890698-stock-photo-ferocious-lion.jpg", comments: 0, createdDate: "3 days age"),
                FeedPost(title: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor ", author: "Author4", thumbPath: nil, comments: 4, createdDate: "4 days age"),
                FeedPost(title: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor ", author: "Author5", thumbPath: nil, comments: 5, createdDate: "5 days age")
            ]
            
            self?.dataSource.append(contentsOf: newDataSource)
            
            DispatchQueue.main.async {
                completion(self?.dataSource ?? [])
            }
        }
    }
}
