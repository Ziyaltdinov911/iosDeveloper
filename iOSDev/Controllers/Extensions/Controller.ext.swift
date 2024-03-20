//
//  Controller.ext.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 17.03.2024.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath) as! PhotoCell
        if let photo = photos?[indexPath.item] {
            cell.configure(with: photo)
        }
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath) as! PhotoCell
        
        guard indexPath.item < favorites.count else {
            return cell
        }
        
        let note = favorites[indexPath.item]
        let photo = Photo(id: note.id, urls: PhotoUrl(small: "", full: "", regular: note.photoUrl), description: note.header) //
        cell.configure(with: photo)
        
        return cell
    }
}

extension Notification.Name {
    static let favoriteRemoved = Notification.Name("favoriteRemoved")
}
