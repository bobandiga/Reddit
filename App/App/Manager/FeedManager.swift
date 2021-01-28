//
//  FeedManager.swift
//  App
//
//  Created by Максим Шаптала on 27.01.2021.
//

import Foundation
import CoreType

protocol FeedManager {
    var dataSource: SafeArray<FeedPost> { get }
    func loadMore(_ completion: @escaping (Error?) -> Void)
    func loadFirst(_ completion: @escaping (Error?) -> Void)
}


