//
//  SearchGroupsAPI.swift
//  vkClient
//
//  Created by Василий Слепцов on 20.09.2021.
//

import Foundation
import Alamofire

final class SearchGroupsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.131"
    
    func getGroups(completion: @escaping([Group]) -> ()) {
        
        let method = "/search.getHints"
        
        let parameters: Parameters = [
            "user_id": userId,
            "extended": 1,
            "count": 5,
            "fields": "members_count, status",
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            print(response.result)
        }
    }
}
