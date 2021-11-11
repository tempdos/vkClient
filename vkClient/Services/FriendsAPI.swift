//
//  FriendsAPI.swift
//  vkClient
//
//  Created by Василий Слепцов on 20.09.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

final class FriendsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.131"
    
    func getFriends(completion: @escaping([User]) -> ()) {
        
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "order": "name",
            "count": 5,
            "fields": "photo_100",
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let data = response.data else { return }
            
            do {
                
                let friendsJSON = try JSON(data: data)["response"]["items"].rawData()
                let friends = try JSONDecoder().decode([User].self, from: friendsJSON)
                
                completion(friends)
            } catch {
                print(error)
            }
        }
    }
}
