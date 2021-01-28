//
//  FeedResponseParser.swift
//  App
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation

struct TopResponse: Decodable {
    let data: TopChildred
    
    var after: String {
        return data.after
    }
    
    var posts: [FeedPost] {
        return data.children.map { FeedPost(title: $0.data.title, author: $0.data.author, thumbPath: nil, comments: $0.data.comments, createdDate: "") }
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
    
    private enum CodingKeys: String, CodingKey {
        case author, title, created
        case comments = "num_comments"
    }
   
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try container.decode(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        created = try container.decode(TimeInterval.self, forKey: .created)
        comments = try container.decode(Int.self, forKey: .comments)
    }
    
}
