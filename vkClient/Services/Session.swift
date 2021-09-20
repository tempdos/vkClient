//
//  Session.swift
//  vkClient
//
//  Created by Василий Слепцов on 09.09.2021.
//

import UIKit

final class Session {
    
    private init() {}
    
    static let shared = Session()
    
    var token: String = ""
    var userId: Int = 0
}
