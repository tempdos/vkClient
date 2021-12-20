//
//  DisplayUsersAPI.swift
//  vkClient
//
//  Created by Василий Слепцов on 13.12.2021.
//

import UIKit

class DisplayUsersAPI: Operation {
    var friendsViewController: FriendsViewController
    
    override func main() {
        guard let displayUsersData = dependencies.first as? ParseUsersAPI,
              let users = displayUsersData.users else { return }
        friendsViewController.friends = users
        friendsViewController.tableView.reloadData()
    }
    
    init(controller: FriendsViewController) {
        self.friendsViewController = controller
    }
}
