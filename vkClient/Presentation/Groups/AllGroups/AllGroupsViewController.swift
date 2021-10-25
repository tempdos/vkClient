//
//  AllGroupsViewController.swift
//  vkClient
//
//  Created by Василий Слепцов on 27.07.2021.
//

import UIKit

final class AllGroupsViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var groups = GroupStorage().allGroups
    var filteredGroups: [Group]!
    
    let searchGroups = GroupsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        filteredGroups = groups
    }
    
    
    // MARK: Search Bar Config
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredGroups = [Group]()
        
        
        
        if searchText == "" {
            filteredGroups = groups
        } else {
            for group in groups  {
                if group.name.lowercased().contains(searchText.lowercased()) {
                    filteredGroups.append(group)
                }
            }
        }
        self.tableView.reloadData()
    }
    
}

extension AllGroupsViewController: UITableViewDelegate {
    
}

extension AllGroupsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reusedIdentifier, for: indexPath) as? GroupsTableViewCell
        else {
            return UITableViewCell()
        }
        
        let group = filteredGroups[indexPath.row]
        cell.configure(group: group)
        return cell
    }
}
