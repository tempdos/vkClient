//
//  Group.swift
//  vkClient
//
//  Created by Василий Слепцов on 27.07.2021.
//

import Foundation
import RealmSwift

class Groups: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var photo100: String
    @objc dynamic var name: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case name
    }
}
