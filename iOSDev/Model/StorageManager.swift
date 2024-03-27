//
//  StorageManager.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 20.03.2024.
//

import Foundation
import Alamofire

struct Photo: Codable {
    let id: String
    let urls: PhotoUrl
}

struct PhotoUrl: Codable {
    let small: String
    let full: String
    let regular: String
}

class StorageManager {
    
    func getPath() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func saveImage(data: Data, name: String, folderName: String) {
        var path = getPath()
        path.appendPathComponent(folderName)
        try! FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
        path.appendPathComponent(name)
        
        do {
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getImage(imgName: String, folderName: String) -> Data? {
        var path = getPath()
        path.appendPathComponent(folderName)
        path.appendPathComponent(imgName)
        return try? Data(contentsOf: path)
    }
    
    func getPhotos(completion: @escaping (Result<[Photo]?, Error>) -> Void) {
        let parameters: [String: Any] = [
            "client_id": "Nq_yNS_Fh7nQrCiZ38ahoaQ9HcPM8bZ9yAiEaANZVkY",
            "count": 1
        ]

        AF.request("https://api.unsplash.com/photos/random", method: .get, parameters: parameters).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let photos = try JSONDecoder().decode([Photo].self, from: data)
                        completion(.success(photos))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }




}
