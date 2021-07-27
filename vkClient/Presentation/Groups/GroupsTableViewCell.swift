//
//  GroupsTableViewCell.swift
//  vkClient
//
//  Created by Василий Слепцов on 27.07.2021.
//

import UIKit

final class GroupsTableViewCell: UITableViewCell {
    
    static let reusedIdentifier = "GroupsTableViewCell"

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var avatarImageView: UIImageView!
    
    func configure(group: Group) {
        avatarImageView.image = UIImage(named: group.avatar)
        nameLabel.text = group.name
    }
}
