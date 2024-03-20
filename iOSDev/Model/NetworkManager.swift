//
//  NetworkManager.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 11.03.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func getPhotos(completion: @escaping (Result<[Photo]?, Error>) -> Void){

        let parameters: Parameters = [
            "client_id": "Nq_yNS_Fh7nQrCiZ38ahoaQ9HcPM8bZ9yAiEaANZVkY",
            "count": 5,
            "description": "A man drinking a coffee.",
        ]

        AF.request("https://api.unsplash.com/photos/random", method: .get, parameters: parameters).response { result in
            
            guard result.error == nil else {
                completion(.failure(result.error!))
                return
            }
            
            if let data = result.data {
                let photos = try? JSONDecoder().decode([Photo].self, from: data)
                completion(.success(photos))
            }
        }
    }
}

struct Photo: Codable {
    let id: String
    let urls: PhotoUrl
    let description: String?
}

struct PhotoUrl: Codable{
    let small: String
    let full: String
    let regular: String
}
