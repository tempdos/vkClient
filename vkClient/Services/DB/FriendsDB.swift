//
//  FriendsDB.swift
//  vkClient
//
//  Created by Василий Слепцов on 07.11.2021.
//

import Foundation
import RealmSwift

final class FriendsDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 4)
    }

    
    func create(_ users: [User]) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(users)
        }
        print(realm.configuration.fileURL ?? "")
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
}
