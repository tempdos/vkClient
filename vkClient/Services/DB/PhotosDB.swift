//
//  PhotosDB.swift
//  vkClient
//
//  Created by Василий Слепцов on 09.11.2021.
//

import Foundation
import RealmSwift

final class PhotosDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 7)
    }

    
    func create(_ photo: Photo) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(photo)
        }
    }
    
    func read() -> Results<Photo> {
        
        let realm = try! Realm()
        let photo: Results<Photo> = realm.objects(Photo.self)
        return photo
    }
    
    func delete(_ photo: Photo) {
        
        let realm = try! Realm()
        try! realm.write{
            realm.delete(photo)
        }
    }
    
    func readOne(_ id: Int) -> Bool {
        let realm = try! Realm()
        let photo = realm.objects(Photo.self).filter("id = %@", id)
        if photo.isEmpty {
            return false
        } else {
            return true
        }
    }
}
