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
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 10)
    }

    
    func create(_ group: Groups) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(group)
        }
    }
    
    func read() -> Results<Groups> {
        
        let realm = try! Realm()
        let group: Results<Groups> = realm.objects(Groups.self)
        return group
    }
    
    func delete(_ group: Groups) {
        
        let realm = try! Realm()
        try! realm.write{
            realm.delete(group)
        }
    }
    
    func readOne(_ name: String) -> Bool {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "name = %@", name)
        let group = realm.objects(Groups.self).filter(predicate)
        if group.isEmpty {
            return false
        } else {
            return true
        }
    }
}
