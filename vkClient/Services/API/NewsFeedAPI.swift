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
    
    func getNewsFeed(completion: @escaping([News], [NewsGroup], [NewsProfile]) -> ()) {
        
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
            
            let newsDispatchGroup = DispatchGroup()
            
            var posts: [News] = []
            var groups: [NewsGroup] = []
            var profiles: [NewsProfile] = []

            DispatchQueue.global().async(group: newsDispatchGroup) {
                do {

                    let newsJSON = try JSON(data: data)["response"]["items"].rawData()
                    posts = try JSONDecoder().decode([News].self, from: newsJSON)
                    debugPrint(posts)
                } catch {
                    print(error)
                }
            }
            
            DispatchQueue.global().async(group: newsDispatchGroup) {
                do {
                    let newsGroupsJSON = try JSON(data: data)["response"]["groups"].rawData()
                    groups = try JSONDecoder().decode([NewsGroup].self, from: newsGroupsJSON)
                    debugPrint(groups)
                } catch {
                    print(error)
                }
            }
            
            DispatchQueue.global().async(group: newsDispatchGroup) {
                do {
                    let newsProfilesJSON = try JSON(data: data)["response"]["profiles"].rawData()
                    profiles = try JSONDecoder().decode([NewsProfile].self, from: newsProfilesJSON)
                    debugPrint(profiles)
                } catch {
                    print(error)
                }
            }
            
            newsDispatchGroup.notify(queue: DispatchQueue.main) {
                debugPrint("Done")
                completion(posts, groups, profiles)
            }
        }
    }
}
