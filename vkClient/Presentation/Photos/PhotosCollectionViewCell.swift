//
//  PhotosCollectionViewCell.swift
//  vkClient
//
//  Created by Василий Слепцов on 26.07.2021.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotosCollectionViewCell"
    @IBOutlet var photoImageView: UIImageView!
    
    
    func configure(photo: Photo) {
        let url = URL(string: photo.sizes[0].url)
        if let data = try? Data(contentsOf: url!)
        {
            photoImageView.image = UIImage(data: data)
        }
    }
}
