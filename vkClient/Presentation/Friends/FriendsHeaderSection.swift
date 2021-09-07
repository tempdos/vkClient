//
//  FriendsHeaderSection.swift
//  vkClient
//
//  Created by Василий Слепцов on 11.08.2021.
//

import UIKit

final class FriendsHeaderSection: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "FriendsHeaderSection"
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
    }
    
    func configure(title: String?) {
        label.text = title
    }
    
    private func setViews() {
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
}
