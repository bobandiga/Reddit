//
//  FeedManager.swift
//  App
//
//  Created by Максим Шаптала on 27.01.2021.
//

import Foundation

protocol FeedManager {
    var dataSource: [FeedPost] { get }
    func loadMore(_ completion: @escaping ([FeedPost]) -> Void)
    func loadFirst(_ completion: @escaping () -> Void)
}


