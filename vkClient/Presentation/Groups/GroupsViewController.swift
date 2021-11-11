//
//  GroupsViewController.swift
//  vkClient
//
//  Created by Василий Слепцов on 11.07.2021.
//

import UIKit
import RealmSwift

class GroupsViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    // Services
    private let groupsAPI = GroupsAPI()
    private let groupsDB = GroupsDB()
    
    // Data source
    private var groups: Results<Group>?
    private var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsAPI.getGroups { [weak self] groups in
            guard let self = self else { return }
            
            groups.forEach { group in
                let check = self.groupsDB.readOne(group.name)
                if !check {
                    self.groupsDB.create(group)
                }
            }
            self.groups = self.groupsDB.read()
            
            self.token = self.groups?.observe { [weak self] changes in
                self?.tableView.reloadData()
            }
        }
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
                
        if !(groups?.contains(where: { $0.name == group.name }) ?? false) {
//            groups.append(group)
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
        groups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reusedIdentifier, for: indexPath) as? GroupsTableViewCell
        else {
            return UITableViewCell()
        }
        
        let group = groups?[indexPath.row]
        cell.configure(group: group!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToAllGroups", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Если была нажата кнопка "Удалить"
        if editingStyle == .delete {
            // Удаляем город из массива
//            groups.remove(at: indexPath.row)
            // И удаляем строку из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
