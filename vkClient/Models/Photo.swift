//
//  PhotoModel.swift
//  vkClient
//
//  Created by Василий Слепцов on 22.07.2021.
//

import Foundation
import RealmSwift

class Photo: Object, Codable {
    
    @objc dynamic var id: Int
    @objc dynamic var sizes: Size

    enum CodingKeys: String, CodingKey {
        case id
        case sizes
    }
}

class Size: Object, Codable {
    @objc dynamic var url: String
    @objc dynamic var type: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case type
    }
}
