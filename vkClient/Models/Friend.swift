//
//  Friend.swift
//  vkClient
//
//  Created by Василий Слепцов on 24.10.2021.
//

import Foundation

struct Friend: Codable {
    let id: Int
    let photo100: String
    let lastName: String
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case firstName = "first_name"
    }
}
