//
//  Group.swift
//  vkClient
//
//  Created by Василий Слепцов on 27.07.2021.
//

import Foundation

struct Group: Codable {
    let id: Int
    let photo100: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case name
    }
}
