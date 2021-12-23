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
    
    func getNewsFeed(completion: @escaping(News?) -> ()) {
        
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
            
            let newsDispatchGroup = DispatchGroup()
            
            var items: [Item] = []
            var groups: [Group] = []
            var profiles: [Profile] = []

            DispatchQueue.global().async(group: newsDispatchGroup) {
                do {
                    let newsJSON = try JSON(data: data)["response"]["items"].rawData()
                    items = try JSONDecoder().decode([Item].self, from: newsJSON)
                    debugPrint(items)
                } catch {
                    print(error)
                }
            }
            
            DispatchQueue.global().async(group: newsDispatchGroup) {
                do {
                    let newsGroupsJSON = try JSON(data: data)["response"]["groups"].rawData()
                    groups = try JSONDecoder().decode([Group].self, from: newsGroupsJSON)
                    debugPrint(groups)
                } catch {
                    print(error)
                }
            }
            
            DispatchQueue.global().async(group: newsDispatchGroup) {
                do {
                    let newsProfilesJSON = try JSON(data: data)["response"]["profiles"].rawData()
                    profiles = try JSONDecoder().decode([Profile].self, from: newsProfilesJSON)
                    debugPrint(profiles)
                } catch {
                    print(error)
                }
            }
            
            newsDispatchGroup.notify(queue: DispatchQueue.main) {
                let response = NewsResponse(items: items, profiles: profiles, groups: groups)
                let news = News(response: response)
                completion(news)
            }
        }
    }
}
