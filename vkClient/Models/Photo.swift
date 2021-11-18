//
//  PhotoModel.swift
//  vkClient
//
//  Created by Василий Слепцов on 22.07.2021.
//

import Foundation
import RealmSwift

class Photo: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var assetUrl: String = ""
    @objc dynamic var userId: Int = 0
    
    var sizes: [Size]
    
    var photoUrl: String {
        guard let size = sizes.last else { return "" }
        return size.url
    }
    

    enum CodingKeys: String, CodingKey {
        case id
        case sizes
    }
}

struct Size: Codable {
    var url: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case type
    }
}
