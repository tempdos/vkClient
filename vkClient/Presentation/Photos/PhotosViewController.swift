//
//  PhotosViewController.swift
//  vkClient
//
//  Created by Василий Слепцов on 26.07.2021.
//

import UIKit
import RealmSwift

class PhotosViewController: UIViewController, CaruselViewControllerDelegate  {
    
    @IBOutlet var collectionView: UICollectionView!
    
    weak var caruselDelegate: CaruselViewControllerDelegate?
    
    // Services
    private let photosAPI = PhotosAPI()
    private let photosDB = PhotosDB()
    
    // Data source
    private var photos: Results<Photo>?
    private var token: NotificationToken?
    
    var user_id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        caruselDelegate = self
        photosAPI.getPhotos(user_id: user_id) { [weak self] photos in
            
            guard let self = self else { return }
            photos.forEach { photo in
                let check = self.photosDB.readOne(photo.id)
                if !check {
                    self.photosDB.create(photo)
                }
            }
            self.photos = self.photosDB.read(self.user_id)
            
            self.collectionView.reloadData()
        }
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
        guard let photos = self.photos else { return 0 }
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        let photo = self.photos?[indexPath.item]
        if let photoUrl = URL(string: photo?.assetUrl ?? "") {
            cell.photoImageView.load(url: photoUrl)
        }
        return cell
    }
    
    
}

protocol  CaruselViewControllerDelegate: AnyObject {
    func showPresenter(photos: [Photo], selectedPhoto: Int )
}
