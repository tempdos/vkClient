//
//  NewsFeedTableViewCell.swift
//  vkClient
//
//  Created by Василий Слепцов on 22.11.2021.
//

import UIKit

final class NewsFeedTableViewCell: UITableViewCell {

    static let reusedIdentifier = "NewsFeedTableViewCell"

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var avatarImageView: UIImageView!

    func configure(group: Group) {
        let url = URL(string: group.photo100)
        if let data = try? Data(contentsOf: url!)
        {
            avatarImageView.image = UIImage(data: data)
        }
        nameLabel.text = group.name
    }
}
