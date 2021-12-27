//
//  GetUsersAPI.swift
//  vkClient
//
//  Created by Василий Слепцов on 13.12.2021.
//

import Foundation
import Alamofire

final class GetUsersAPI: Operation {
    
    var data: Data?
    
    override func main() {
        
        let token = Session.shared.token
        let userId = Session.shared.userId
        let version = "5.131"
        
        var requestConstructor = URLComponents()
        requestConstructor.scheme = "https"
        requestConstructor.host = "api.vk.com"
        requestConstructor.path = "/method/friends.get"
        requestConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(userId)"),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "access_token", value: "\(token)"),
            URLQueryItem(name: "v", value: "\(version)")
        ]
        guard let url = requestConstructor.url else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        self.data = data
    }
}
