//
//  FriendsViewController.swift
//  vkClient
//
//  Created by Василий Слепцов on 11.07.2021.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet var letterControl: LettersControl!
    @IBOutlet var tableView: UITableView!
    
    var friendsSection = [[User]]()
    private var firstLetters: [String] = []
    
    let friendsAPI = FriendsAPI()
    var friends = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsAPI.getFriends { user in
            self.friends = user
        }
        friends = friends.sorted(by: { $0.firstName < $1.firstName })
        firstLetters = getFirstLetters(friends)
        letterControl.setLetters(firstLetters)
        letterControl.addTarget(self, action: #selector(scrollToLetter), for: .valueChanged)
        
        friendsSection = sortedForSection(friends, firstLetters: firstLetters)
        
        tableView.register(FriendsHeaderSection.self, forHeaderFooterViewReuseIdentifier: FriendsHeaderSection.reuseIdentifier)
        self.tableView.reloadData()
    }
    
    @objc func scrollToLetter() {
        let letter = letterControl.selectLetter
        guard
            let firstIndexForLetter = friendsSection.firstIndex(where: { String($0.first?.firstName.prefix(1) ?? "") == letter })
        else {
            return
        }

        tableView.scrollToRow(
            at: IndexPath(row: 0, section: firstIndexForLetter),
            at: .top,
            animated: true)
    }

    
    private func getFirstLetters(_ friends: [User]) -> [String] {
        let friendsName = friends.map { $0.firstName }
        let firstLetters = Array(Set(friendsName.map { String($0.prefix(1)) })).sorted()
        return firstLetters
    }
    
    private func sortedForSection(_ friends: [User], firstLetters: [String]) -> [[User]] {
        var friendsSorted: [[User]] = []
        firstLetters.forEach { letter in
            let friendsForLetter = friends.filter { String($0.firstName.prefix(1)) == letter }
            friendsSorted.append(friendsForLetter)
        }
        return friendsSorted
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "moveToPhotos",
           let destinationController = segue.destination as? PhotosViewController,
           let indexPath = sender as? IndexPath
        {
            let friend = friendsSection[indexPath.section][indexPath.row]
            destinationController.title = "\(friend.firstName)+\(friend.lastName)"
        }
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        friendsSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendsSection[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.reusedIdentifier, for: indexPath) as? FriendTableViewCell
        else {
            return UITableViewCell()
        }
        let friend = friendsSection[indexPath.section][indexPath.row]
        cell.configure(user: friend)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToPhotos", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendsHeaderSection.reuseIdentifier) as? FriendsHeaderSection
        else {
            return nil
        }
        header.configure(title: firstLetters[section])
        return header
    }
}
