//
//  GroupsViewController.swift
//  vkClient
//
//  Created by Василий Слепцов on 11.07.2021.
//

import UIKit

class GroupsViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    var groups: [Group] = []
    let groupsAPI = GroupsAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsAPI.getGroups { items in
            print(items)
        }
        
        let storage = GroupStorage()
        groups = storage.groups
    }
    
    @IBAction func addGroup(_ segue: UIStoryboardSegue) {
         
        guard
            segue.identifier == "addGroup",
            let sourceController = segue.source as? AllGroupsViewController,
            let indexPath = sourceController.tableView.indexPathForSelectedRow
        else {
            return
        }
        let group = sourceController.groups[indexPath.row]
                
        if !groups.contains(where: { $0.name == group.name }) {
            groups.append(group)
            tableView.reloadData()
        }
        
    }
}

extension GroupsViewController: UITableViewDelegate {
    
}
extension GroupsViewController: UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToAllGroups", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Если была нажата кнопка "Удалить"
        if editingStyle == .delete {
            // Удаляем город из массива
            groups.remove(at: indexPath.row)
            // И удаляем строку из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
