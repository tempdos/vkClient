//
//  PhotoModel.swift
//  vkClient
//
//  Created by Василий Слепцов on 22.07.2021.
//

import Foundation
import RealmSwift

class Photo: Object, Codable {
    
    @objc dynamic let id: Int
    @objc dynamic let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case id
        case sizes
    }
}

class Size: Object, Codable {
    @objc dynamic let url: String
    @objc dynamic let type: String
}
