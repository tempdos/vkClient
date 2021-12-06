//
//  NewsGroup.swift
//  vkClient
//
//  Created by Василий Слепцов on 06.12.2021.
//

import Foundation

struct NewsGroup: Codable {
    let id: Int
    let photo200: String
    let type, screenName, name: String
    let isClosed: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}
