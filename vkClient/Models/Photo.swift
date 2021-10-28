//
//  PhotoModel.swift
//  vkClient
//
//  Created by Василий Слепцов on 22.07.2021.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case id
        case sizes
    }
}

struct Size: Codable {
    let url: String
    let type: String
}
