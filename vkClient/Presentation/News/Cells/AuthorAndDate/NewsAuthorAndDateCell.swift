//
//  NewsAuthorAndDate.swift
//  vkClient
//
//  Created by Василий Слепцов on 06.12.2021.
//

import UIKit

final class NewsAuthorAndDateCell: UITableViewCell {
    static let reusedIdentifier = "NewsAuthorAndDate"
    
    @IBOutlet var newsAuthorLabel: UILabel!
    @IBOutlet var newsDateLabel: UILabel!
    
    func configure(author: String, date: String) {
        newsAuthorLabel.text = author
        newsDateLabel.text = date
    }
}
