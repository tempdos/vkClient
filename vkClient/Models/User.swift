//
//  FriendModel.swift
//  vkClient
//
//  Created by Василий Слепцов on 22.07.2021.
//

import Foundation
import RealmSwift

class User: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var photo100: String
    @objc dynamic var lastName: String
    @objc dynamic var firstName: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case firstName = "first_name"
    }
}
