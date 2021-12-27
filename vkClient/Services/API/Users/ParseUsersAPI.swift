//
//  ParseUsersAPI.swift
//  vkClient
//
//  Created by Василий Слепцов on 13.12.2021.
//

import Foundation
import SwiftyJSON

final class ParseUsersAPI: Operation {
    var users: [User]? = []
    
    override func main() {
        guard let usersData = dependencies.first as? GetUsersAPI,
              let data = usersData.data else { return }
        
        do {
            let usersJSON = try JSON(data: data)["response"]["items"].rawData()
            self.users = try JSONDecoder().decode([User].self, from: usersJSON)
        } catch {
            debugPrint(error)
        }
    }
}
