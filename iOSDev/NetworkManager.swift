//
//  NetworkManager.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 06.03.2024.
//

import Foundation

class NetworkManager {
    
    func getNews(q: String, completion: @escaping ([NewsArticle]?) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/everything"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: "79c6e79f60a24fbb8e66ced0e0b80ac9"),
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "language", value: "ru")
        ]
        
        
        guard let url = urlComponents.url else { return}
        
        let req = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: req) { data, _, err in
            
            guard err == nil else {
                print(err!.localizedDescription)
                return
            }
            
            if let jsonData = data {
                let responceData = try? JSONDecoder().decode(ResponceModel.self, from: jsonData)
                let res = responceData?.articles
                completion(res)
            }
        }.resume()
    
    }
}
