//
//  GroupsAPI.swift
//  vkClient
//
//  Created by Василий Слепцов on 20.09.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

final class GroupsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.131"
    
    func getGroups(completion: @escaping([Groups]) -> ()) {
        
        let method = "/groups.get"
        
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
            
            guard let data = response.data else { return }

            do {

                let groupsJSON = try JSON(data: data)["response"]["items"].rawData()
                let groups = try JSONDecoder().decode([Groups].self, from: groupsJSON)

                completion(groups)
            } catch {
                print(error)
            }
        }
    }
    
    func searchGroups(query: String, completion: @escaping([Groups]) -> ()) {
        
        let method = "/groups.search"
        
        let parameters: Parameters = [
            "q": query,
            "type": "group",
            "count": 5,
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let data = response.data else { return }

            do {

                let groupsJSON = try JSON(data: data)["response"]["items"].rawData()
                let groups = try JSONDecoder().decode([Groups].self, from: groupsJSON)

                completion(groups)
            } catch {
                print(error)
            }
        }
    }
    
    func requestGroups() -> Promise<Data> {
        return Promise<Data> { resolver in
            let method = "/groups.get"
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
                if let error = response.error {
                    resolver.reject(error)
                }
                if let data = response.data {
                    resolver.fulfill(data)
                }
            }
        }
    }
    
    func parseGroups(from data: Data) -> Promise<Data> {
        return Promise<Data> { resolver in
            do {
                let groupsJSON = try JSON(data: data)["response"]["items"].rawData()
                resolver.fulfill(groupsJSON)
            } catch {
                resolver.reject(error)
            }
        }
    }
    
    func showGroups(from groupsResponse: Data) -> Promise<[Groups]> {
        return Promise<[Groups]> { resolver in
            let groups = try JSONDecoder().decode([Groups].self, from: groupsResponse)
            resolver.fulfill(groups)
        }
    }
}
