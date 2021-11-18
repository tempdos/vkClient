//
//  PhotosAPI.swift
//  vkClient
//
//  Created by Василий Слепцов on 20.09.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

final class PhotosAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.131"
    
    func getPhotos(user_id: Int, completion: @escaping([Photo]) -> ()) {
        
        let method = "/photos.get"
        
        let parameters: Parameters = [
            "owner_id": user_id,
            "album_id": "wall",
            "extended": 1,
            "count": 5,
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let data = response.data else { return }
            
            do {
                
                let photosJSON = try JSON(data)["response"]["items"].rawData()
                let photos = try JSONDecoder().decode([Photo].self, from: photosJSON)
                for photo in photos {
                    photo.assetUrl = photo.photoUrl
                    photo.userId = user_id
                }
                completion(photos)
            } catch {
                print(error)
            }
        }
    }
}
