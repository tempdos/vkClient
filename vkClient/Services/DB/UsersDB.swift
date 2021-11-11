//
//  FriendsDB.swift
//  vkClient
//
//  Created by Василий Слепцов on 07.11.2021.
//

import Foundation
import RealmSwift

final class UsersDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 6)
    }

    
    func create(_ user: User) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(user)
        }
    }
    
    func read() -> Results<User> {
        
        let realm = try! Realm()
        let users: Results<User> = realm.objects(User.self)
        return users
    }
    
    func delete(_ user: User) {
        
        let realm = try! Realm()
        try! realm.write{
            realm.delete(user)
        }
    }
    
    func readOne(_ lastName: String) -> Bool {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "lastName = %@", lastName)
        let user = realm.objects(User.self).filter(predicate)
        if user.isEmpty {
            return false
        } else {
            return true
        }
    }
}
