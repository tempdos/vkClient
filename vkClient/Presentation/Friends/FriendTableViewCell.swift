//
//  FriendTableViewCell.swift
//  vkClient
//
//  Created by Василий Слепцов on 25.07.2021.
//

import UIKit

final class FriendTableViewCell: UITableViewCell {
    static let reusedIdentifier = "FriendTableViewCell"
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    func configure(user: User) {
        avatarImageView.image = UIImage(named: user.avatar)
        nameLabel.text = user.name
    }
}
