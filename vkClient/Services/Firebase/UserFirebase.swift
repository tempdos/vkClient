//
//  UserFirebase.swift
//  vkClient
//
//  Created by Василий Слепцов on 15.11.2021.
//

import Foundation
import Firebase

class UserFirebase {
    
    let id: String
    let ref: DatabaseReference?
    
    init(id: String) {
        self.ref = nil
        self.id = id
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? String
        else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.id = id
    }
    
    func toAnyObject() -> [AnyHashable: Any] {
        return ["id": id] as [AnyHashable: Any]
    }
}
