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
    
    func configure(group: Groups) {
        let url = URL(string: group.photo100)
        if let data = try? Data(contentsOf: url!)
        {
            avatarImageView.image = UIImage(data: data)
        }
        nameLabel.text = group.name
    }
}
