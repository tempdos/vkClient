//
//  Session.swift
//  vkClient
//
//  Created by Василий Слепцов on 09.09.2021.
//

import UIKit
import SwiftKeychainWrapper

final class Session {
    
    private init() {}
    
    static let shared = Session()
    
    var token: String {
        
        set {
            KeychainWrapper.standard.set(newValue, forKey: "token")
        }
        get {
            KeychainWrapper.standard.string(forKey: "token") ?? ""
        }
    }
    
    var userId: String {
        
        set {
            KeychainWrapper.standard.set(newValue, forKey: "userId")
        }
        get {
            KeychainWrapper.standard.string(forKey: "userId") ?? ""
        }
    }
}
