//
//  PhotosViewController.swift
//  vkClient
//
//  Created by Василий Слепцов on 26.07.2021.
//

import UIKit

class PhotosViewController: UIViewController, CaruselViewControllerDelegate  {
    
    @IBOutlet var collectionView: UICollectionView!
    
    weak var caruselDelegate: CaruselViewControllerDelegate?
    
    var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        caruselDelegate = self
    }
    
    func showPresenter(photos: [Photo], selectedPhoto: Int){
        let presentVC = CaruselViewController()
        presentVC.photos = photos
        presentVC.selectedPhoto = selectedPhoto
        navigationController?.pushViewController(presentVC, animated: true)
    }
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        caruselDelegate?.showPresenter(photos: photos, selectedPhoto: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        let photo = photos[indexPath.item]
        cell.configure(photo: photo)
        return cell
    }
    
    
}

protocol  CaruselViewControllerDelegate: AnyObject {
    func showPresenter(photos: [Photo], selectedPhoto: Int )
}
