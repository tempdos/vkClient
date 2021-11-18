//
//  GroupsDB.swift
//  vkClient
//
//  Created by Василий Слепцов on 09.11.2021.
//

import Foundation
import RealmSwift

final class GroupsDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 7)
    }

    
    func create(_ group: Group) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(group)
        }
    }
    
    func read() -> Results<Group> {
        
        let realm = try! Realm()
        let group: Results<Group> = realm.objects(Group.self)
        return group
    }
    
    func delete(_ group: Group) {
        
        let realm = try! Realm()
        try! realm.write{
            realm.delete(group)
        }
    }
    
    func readOne(_ name: String) -> Bool {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "name = %@", name)
        let group = realm.objects(Group.self).filter(predicate)
        if group.isEmpty {
            return false
        } else {
            return true
        }
    }
}
