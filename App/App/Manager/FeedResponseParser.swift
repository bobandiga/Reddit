//
//  FeedResponseParser.swift
//  App
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation
import TrueDateFormatter

struct TopResponse: Decodable {
    let data: TopChildred
    
    var after: String {
        return data.after
    }
    
    var posts: [FeedPost] {
        return data.children.map { FeedPost(title: $0.data.title, author: $0.data.author, thumbPath: $0.data.thumbnail, comments: $0.data.comments, createdDate: mapIntervalToDate($0.data.created)) }
    }
    
    private func mapIntervalToDate(_ timeInterval: TimeInterval?) -> String? {
        
        guard let timeInterval = timeInterval else { return nil }
        let date = Date(timeIntervalSince1970: timeInterval)
        return .toElapsedTime(from: date)
        
    }
}

struct TopChildred: Decodable {
    let after: String
    let children: [ForChildData]
}

struct ForChildData: Decodable {
    let data: TopChildData
}

struct TopChildData: Decodable {
    let author: String?
    let title: String?
    let created: TimeInterval?
    let comments: Int?
    let thumbnail: String?
    
    private enum CodingKeys: String, CodingKey {
        case author, title, created, thumbnail
        case comments = "num_comments"
    }
   
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try container.decode(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        created = try container.decode(TimeInterval.self, forKey: .created)
        comments = try container.decode(Int.self, forKey: .comments)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
    }
    
}
