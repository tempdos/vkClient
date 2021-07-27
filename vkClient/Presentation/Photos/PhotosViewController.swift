//
//  PhotosViewController.swift
//  vkClient
//
//  Created by Василий Слепцов on 26.07.2021.
//

import UIKit

final class PhotosViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        let photo = photos[indexPath.item]
        cell.configure(photo: photo)
        return cell
    }
    
    
}
