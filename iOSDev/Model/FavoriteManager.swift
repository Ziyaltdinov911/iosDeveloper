//
//  FavoriteManager.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 14.03.2024.
//

import Foundation
import UIKit

class FavoriteManager {
    
    static let shared = FavoriteManager()
    
    private var favorites: [Photo] = []
    
    private let favoritesKey = "FavoritePhotos"
    
    private init() {
        loadFavorites()
    }
    
    func addToFavorites(photo: Photo) {
        if !favorites.contains(where: { $0.id == photo.id }) {
            favorites.append(photo)
            saveFavorites(photo: photo)
        }
    }

    func removeFromFavorites(photo: Photo) {
        if let index = favorites.firstIndex(where: { $0.id == photo.id }) {
            favorites.remove(at: index)
            saveFavorites(photo: photo)
        }
    }
    
    func isFavorite(photo: Photo) -> Bool {
        return favorites.contains(where: { $0.id == photo.id })
    }
    
    func getFavorites() -> [Photo] {
        return favorites
    }
    
    private func saveFavorites(photo: Photo) {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let favoritesURL = documentsURL.appendingPathComponent("favorites")

        do {
            try fileManager.createDirectory(at: favoritesURL, withIntermediateDirectories: true, attributes: nil)

            if let imageURL = URL(string: photo.urls.regular) {
                let session = URLSession.shared
                let task = session.dataTask(with: imageURL) { data, response, error in
                    guard let imageData = data, error == nil else {
                        print("Ошибка загрузки изображения для: \(photo.id)")
                        return
                    }

                    if let compressedImageData = UIImage(data: imageData)?.jpegData(compressionQuality: 0.1) {
                        let fileName = UUID().uuidString + ".jpg"
                        let fileURL = favoritesURL.appendingPathComponent(fileName)
                        do {
                            try compressedImageData.write(to: fileURL)
                            print("Избранное сохранено: \(fileURL)")
                        } catch {
                            print("Ошибка сохранения изображения для: \(photo.id): \(error)")
                        }
                    }
                }
                task.resume()
            }
        } catch {
            print("Ошибка сохранения в избранные: \(error)")
        }
    }


    
    private func loadFavorites() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let favoritesURL = documentsURL.appendingPathComponent("favorites")
        
        do {
            if !fileManager.fileExists(atPath: favoritesURL.path) {
                try fileManager.createDirectory(at: favoritesURL, withIntermediateDirectories: true, attributes: nil)
            }
            
            let fileURLs = try fileManager.contentsOfDirectory(at: favoritesURL, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                _ = try Data(contentsOf: fileURL)
                let photo = Photo(id: fileURL.deletingPathExtension().lastPathComponent, urls: PhotoUrl(small: "", full: "", regular: fileURL.absoluteString), description: nil)
                favorites.append(photo)
            }
            print("Избранные успешно загружены")
        } catch {
            print("Ошибка загрузки избранных: \(error)")
        }
    }

}
