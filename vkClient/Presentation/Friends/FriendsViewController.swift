//
//  FriendsViewController.swift
//  vkClient
//
//  Created by Василий Слепцов on 11.07.2021.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    // Services
    private let usersAPI = UsersAPI()
    private let usersDB = UsersDB()
    
    // Data source
    var friends: [User]?
    private var token: NotificationToken?
    
    // Add operations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = OperationQueue.main
        
        let getFriends = GetUsersAPI()
        let parseFriends = ParseUsersAPI()
        let showFriends = DisplayUsersAPI(controller: self)
        
        parseFriends.addDependency(getFriends)
        showFriends.addDependency(parseFriends)
        
        let operations = [getFriends, parseFriends, showFriends]
        queue.addOperations(operations, waitUntilFinished: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "moveToPhotos",
           let destinationController = segue.destination as? PhotosViewController,
           let indexPath = sender as? IndexPath
        {
            let friend = friends?[indexPath.row]
            destinationController.title = "\(friend?.firstName ?? "") \(friend?.lastName ?? "")"
            destinationController.user_id = friend?.id ?? 0
        }
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let friends = friends else { return 0 }
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.reusedIdentifier, for: indexPath) as? FriendTableViewCell
        else {
            return UITableViewCell()
        }
        let friend = friends?[indexPath.row]
        cell.configure(user: friend!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToPhotos", sender: indexPath)
    }
}
