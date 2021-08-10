//
//  LikeControl.swift
//  vkClient
//
//  Created by Василий Слепцов on 31.07.2021.
//

import UIKit


final class LikeControl: UIControl {
    
    private var likeImage = UIImageView()
    private var likeCountLabel = UILabel()
    private var likes: Int = 0
    private var isLike: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        likeImage.frame = bounds
    }
    
    func setLike(count: Int) {
        likes = count
        setLikeCountLabel()
    }
    
    func setView() {
        self.backgroundColor = UIColor(white: 1, alpha: 0.0)
        self.addSubview(likeImage)
        self.addTarget(self, action: #selector(tapControl), for: .touchUpInside)
        
        isLikeColor()
        setLikeCountLabel()
    }
    
    private func isLikeColor() {
        if isLike {
            likeImage.tintColor = .red
            likeCountLabel.textColor = .red
            likeImage.image = UIImage(systemName: "heart.fill")
        } else {
            likeImage.image = UIImage(systemName: "heart")
            likeImage.tintColor = .white
            likeCountLabel.textColor = .white
        }
        setLikeCountLabel()
    }
    
    func setLikeCountLabel() {
        addSubview(likeCountLabel)
        let likeString: String?
        
        switch likes {
        case 0..<1000:
            likeString = String(self.likes)
        case 1000..<1000000:
            likeString = String(self.likes/1000) + "k"
        default:
            likeString = ""
        }
        likeCountLabel.text = likeString
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.trailingAnchor.constraint(equalTo: likeImage.leadingAnchor, constant: -8).isActive = true
        likeCountLabel.centerYAnchor.constraint(equalTo: likeImage.centerYAnchor).isActive = true
    }
    
    @objc func tapControl() {
        isLike.toggle()
        if isLike {
            likes += 1
        } else {
            likes -= 1
        }
        isLikeColor()
    }
}
