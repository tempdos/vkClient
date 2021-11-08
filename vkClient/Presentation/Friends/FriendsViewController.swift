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
    
    var friendsSection = [[User]]()
    private var firstLetters: [String] = []
    
    // Services
    private let friendsAPI = FriendsAPI()
    private let friendsDB = FriendsDB()
    
    // Data source
    private var friends: Results<User>?
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsAPI.getFriends { [weak self] users in
            
            guard let self = self else { return }
            
            self.friendsDB.create(users)
            self.friends = self.friendsDB.read()
            
            self.token = self.friends?.observe { [weak self] changes in
                self?.tableView.reloadData()
            }
        }
//        friends = friends.sorted(by: { $0.firstName < $1.firstName })
//        firstLetters = getFirstLetters(friends)
//        letterControl.setLetters(firstLetters)
//        letterControl.addTarget(self, action: #selector(scrollToLetter), for: .valueChanged)
//
//        friendsSection = sortedForSection(friends, firstLetters: firstLetters)
//
//        tableView.register(FriendsHeaderSection.self, forHeaderFooterViewReuseIdentifier: FriendsHeaderSection.reuseIdentifier)
    }
//
//    @objc func scrollToLetter() {
//        let letter = letterControl.selectLetter
//        guard
//            let firstIndexForLetter = friendsSection.firstIndex(where: { String($0.first?.firstName.prefix(1) ?? "") == letter })
//        else {
//            return
//        }
//
//        tableView.scrollToRow(
//            at: IndexPath(row: 0, section: firstIndexForLetter),
//            at: .top,
//            animated: true)
//    }
//
//
//    private func getFirstLetters(_ friends: [User]) -> [String] {
//        let friendsName = friends.map { $0.firstName }
//        let firstLetters = Array(Set(friendsName.map { String($0.prefix(1)) })).sorted()
//        return firstLetters
//    }
//
//    private func sortedForSection(_ friends: [User], firstLetters: [String]) -> [[User]] {
//        var friendsSorted: [[User]] = []
//        firstLetters.forEach { letter in
//            let friendsForLetter = friends.filter { String($0.firstName.prefix(1)) == letter }
//            friendsSorted.append(friendsForLetter)
//        }
//        return friendsSorted
//    }
    
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
//        let friend = friends?[indexPath.row]
//        cell.configure(user: friend!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToPhotos", sender: indexPath)
    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard
//            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendsHeaderSection.reuseIdentifier) as? FriendsHeaderSection
//        else {
//            return nil
//        }
//        header.configure(title: firstLetters[section])
//        return header
//    }
}
