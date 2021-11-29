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
    let scope = "140488159"
    
    func getNewsFeed(completion: @escaping([News]) -> ()) {
        
        let method = "/newsfeed.get"
        
        let parameters: Parameters = [
            "userId": userId,
            "filters": "post, wall_photo",
            "return_banned": 0,
            "max_photos": 5,
            "count": 5,
            "access_token": token,
            "v": version,
            "scope": scope
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let data = response.data else { return }
            debugPrint(data.prettyJSON as Any)
            do {

                let newsJSON = try JSON(data: data)["response"]["items"].rawData()
                let news = try JSONDecoder().decode([News].self, from: newsJSON)
                for item in news {
                    item.assetUrl = item.photoUrl
                    item.userId = self.userId
                }
                completion(news)
            } catch {
                print(error)
            }
        }
    }
}
