//
//  News.swift
//  vkClient
//
//  Created by Василий Слепцов on 22.11.2021.
//

import Foundation

class News: Codable {
    var text: String = ""
    var assetUrl: String = ""
    var photos: Photos?
    var userId: String = ""
    
    var photoUrl: String {
        guard let items = photos?.items.first,
                let sizes = items.sizes.last else { return "" }
        let url = sizes.url
        
        return url
    }

    enum CodingKeys: String, CodingKey {
        case text
        case photos
    }
}

struct Photos: Codable {
    var items: [PhotosItem]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct PhotosItem: Codable {
    
    var sizes: [SizeNew]
    
    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

struct SizeNew: Codable {
    var url: String
}
