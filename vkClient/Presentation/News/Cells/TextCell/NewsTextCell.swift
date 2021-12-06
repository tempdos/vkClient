//
//  NewsTextCell.swift
//  vkClient
//
//  Created by Василий Слепцов on 06.12.2021.
//

import UIKit

final class NewsTextCell: UITableViewCell {
    static let reusedIdentifier = "NewsTextCell"
    
    @IBOutlet var newsTextLabel: UILabel!
    
    func configure(newsText: String) {
        newsTextLabel.text = newsText
    }
}
