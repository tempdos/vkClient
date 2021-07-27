//
//  AllGroupsViewController.swift
//  vkClient
//
//  Created by Василий Слепцов on 27.07.2021.
//

import UIKit

final class AllGroupsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groups = GroupStorage().allGroups
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension AllGroupsViewController: UITableViewDelegate {
    
}

extension AllGroupsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reusedIdentifier, for: indexPath) as? GroupsTableViewCell
        else {
            return UITableViewCell()
        }
        
        let group = groups[indexPath.row]
        cell.configure(group: group)
        return cell
    }
    
    
}
