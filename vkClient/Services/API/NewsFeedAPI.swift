//
//  NewsFeedAPI.swift
//  vkClient
//
//  Created by Василий Слепцов on 22.11.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

final class NewsFeedAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.131"
    let filters = "post"
    let count = 5
    let method = "/newsfeed.get"
    
    func getNewsFeed(completion: @escaping([News]) -> ()) {
        
        let parameters: Parameters = [
            "userId": userId,
            "filters": filters,
            "count": count,
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let data = response.data else { return }
            debugPrint(data.prettyJSON as Any)
            do {

                let newsJSON = try JSON(data: data)["response"]["items"].rawData()
                let news = try JSONDecoder().decode([News].self, from: newsJSON)
                completion(news)
            } catch {
                print(error)
            }
        }
    }
}
