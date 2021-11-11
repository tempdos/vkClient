//
//  Group.swift
//  vkClient
//
//  Created by Василий Слепцов on 27.07.2021.
//

import Foundation
import RealmSwift

class Group: Object, Codable {
    @objc dynamic let id: Int
    @objc dynamic let photo100: String
    @objc dynamic let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case name
    }
}
