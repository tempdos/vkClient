//
//  GroupStorage.swift
//  vkClient
//
//  Created by Василий Слепцов on 27.07.2021.
//

import Foundation

class GroupStorage {
    let groups: [Group]
    let allGroups: [Group]
    
    init() {
        groups = [
            Group(name: "IOS developers", avatar: "ios"),
        ]
        allGroups = [
            Group(name: "Mac OS developers", avatar: "macos"),
            Group(name: "Geekbrains", avatar: "geek"),
            Group(name: "Android developers", avatar: "android"),
            Group(name: "C# developers", avatar: "windows"),
            Group(name: "C++ developers", avatar: "c++"),
            Group(name: "Java developers", avatar: "java"),
        ]
    }
}
