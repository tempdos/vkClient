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
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        let url = URL(string:user.photo100)
        if let data = try? Data(contentsOf: url!)
        {
            avatarImage.image = UIImage(data: data)
        }
//        avatarImage.image = UIImage(named: user.avatar)
        avatarImage.layer.cornerRadius = avatarImage.frame.height/2
        avatarImage.clipsToBounds = true
        avatarView.addSubview(shadowView)
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.avatarAnimate))
        avatarImage.addGestureRecognizer(tapGR)
        avatarImage.isUserInteractionEnabled = true

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
    
    @objc func avatarAnimate(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                            self.avatarImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                           },
                           completion: {_ in
                            self.avatarImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                           }
                           )
        }
    }
}
