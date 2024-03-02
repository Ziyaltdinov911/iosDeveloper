//
//  NetworkManager.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 02.03.2024.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func dataSuccessfull(totalResults: Int)
    func dataFail(error: Error)
}

class NetworkManager {
    
    weak var delegate: NetworkManagerDelegate?
    
//    https://newsapi.org/v2/everything?q=tesla&from=2024-02-02&sortBy=publishedAt&apiKey=79c6e79f60a24fbb8e66ced0e0b80ac9

    
    func getNews(q: String, lang: String) {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        
        urlComponents.host = "newsapi.org"
        
        urlComponents.path = "/v2/everything"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "apiKey", value: "79c6e79f60a24fbb8e66ced0e0b80ac9"),
            URLQueryItem(name: "language", value: lang),
            URLQueryItem(name: "from", value: "2024-02-02")
        ]
        
        guard let url = urlComponents.url else { return }
        
        let req = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: req) { data, _, err in
                   guard err == nil else {
                       print("Ошибка: \(err!.localizedDescription)")
                       self.delegate?.dataFail(error: err!)

                       return
                   }
                   
                   guard let jsonData = data else {
                       print("Данные не получены")
                       self.delegate?.dataFail(error: err!)

                       return
                   }
                   
                   do {
                       let res = try JSONDecoder().decode(Response.self, from: jsonData)
                       
                       guard let status = res.status else {
                           print("Данные пусты")

                           return
                           
                       }
                       print("Статус: \(status)")

                       
                       guard let totalResults = res.totalResults else {
                           print("Количество результата = nil")
                           return
                       }
                       
                       print("Количество результата: \(totalResults)")
                       
                       self.delegate?.dataSuccessfull(totalResults: totalResults)

                       
                   } catch {
                       print("Ошибка при декодировании JSON: \(error)")
                   }
            
        }.resume()
        
    }

}


struct Response: Decodable {
    let status: String?
    let totalResults: Int?
    
}
