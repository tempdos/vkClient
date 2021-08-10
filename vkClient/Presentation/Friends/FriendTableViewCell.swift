//
//  FriendTableViewCell.swift
//  vkClient
//
//  Created by Василий Слепцов on 25.07.2021.
//

import UIKit

final class FriendTableViewCell: UITableViewCell {
    static let reusedIdentifier = "FriendTableViewCell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var avatarView: UIView!
    @IBOutlet var avatarImage: UIImageView!
    
    func configure(user: User) {
        nameLabel.text = user.name
        avatarImage.image = UIImage(named: user.avatar)
        avatarImage.layer.cornerRadius = avatarImage.frame.height/2
        avatarImage.clipsToBounds = true
        avatarView.addSubview(shadowView)
    }
    
    var shadowView: UIView {
        let shadow = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        shadow.clipsToBounds = false
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOpacity = 1
        shadow.layer.shadowOffset = CGSize.zero
        shadow.layer.shadowRadius = 3
//        shadow.layer.shadowPath = UIBezierPath(roundedRect: avatarImage.bounds, cornerRadius: 1.0).cgPath
        shadow.addSubview(avatarImage)
        return shadow
    }
}
