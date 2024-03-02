//
//  ViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 02.03.2024.
//

import UIKit

class ViewController: UIViewController, NetworkManagerDelegate {
    
    private let networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        networkManager.delegate = self
        networkManager.getNews(q: "iOS", lang: "ru")
        
    }
    
    func dataSuccessfull(totalResults: Int) {
            DispatchQueue.main.async {
                if totalResults > 0 {
                    self.view.backgroundColor = .green
                } else {
                    self.view.backgroundColor = .red
                }
            }
        }
        
        func dataFail(error: Error) {
            print("Error: \(error.localizedDescription)")
        }
    }
