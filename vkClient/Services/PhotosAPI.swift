//
//  PhotosAPI.swift
//  vkClient
//
//  Created by Василий Слепцов on 20.09.2021.
//

import Foundation
import Alamofire

final class PhotosAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.131"
    
    func getPhotos(completion: @escaping([Photo]) -> ()) {
        
        let method = "/photos.get"
        
        let parameters: Parameters = [
            "owner_id": userId,
            "album_id": "wall",
            "extended": 1,
            "count": 5,
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            print(response.result)
        }
    }
}
