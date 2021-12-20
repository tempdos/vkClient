//
//  News.swift
//  vkClient
//
//  Created by Василий Слепцов on 22.11.2021.
//

import Foundation

struct News: Codable {
    
    let text: String
    let canSetCategory, isFavorite: Bool
    let type, postType: String
    let date, sourceID: Int
    let canDoubtCategory: Bool
    let postID: Int

    enum CodingKeys: String, CodingKey {
        case text
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case type
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case canDoubtCategory = "can_doubt_category"
        case postID = "post_id"
    }
}
