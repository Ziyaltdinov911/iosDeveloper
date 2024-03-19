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
        let photo = favorites[indexPath.item]
        cell.configure(with: photo)
        return cell
    }
}
//
//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let photo = photos?[indexPath.item] else {
//            return CGSize(width: collectionView.bounds.width - 40, height: 200)
//        }
//        
//        let imageWidth = photo.urls.regularImageWidth
//        let imageHeight = photo.urls.regularImageHeight
//        
//        let screenWidth = collectionView.bounds.width - 40
//        let aspectRatio = CGFloat(imageHeight) / CGFloat(imageWidth)
//        let cellHeight = screenWidth * aspectRatio
//        
//        return CGSize(width: screenWidth, height: cellHeight)
//    }
//}
