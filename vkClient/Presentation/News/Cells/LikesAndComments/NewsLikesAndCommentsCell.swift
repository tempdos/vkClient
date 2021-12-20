//
//  NewsLikeAndCommentsCell.swift
//  vkClient
//
//  Created by Василий Слепцов on 06.12.2021.
//

import UIKit

final class NewsLikesAndCommentsCell: UITableViewCell {
    static let reusedIdentifier = "NewsLikeAndCommentsCell"
    @IBOutlet var newsLikeLabel: UILabel!
    @IBOutlet var newsCommentsLabel: UILabel!
    
    func configure(likes: Int, comments: Int) {
        newsLikeLabel.text = String(likes)
        newsCommentsLabel.text = String(comments)
    }
}
