//
//  DetailsPhotoCell.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 22.02.2024.
//

import UIKit

class DetailsPhotoCell: UICollectionViewCell, CollectionViewCellProtocol {
    static let reuseId: String = "DetailsPhotoCell"
    
    lazy var cellImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        
        return $0
    }(UIImageView(frame: bounds))
    
    lazy var imageMenuButton: UIButton = {
        $0.setBackgroundImage(UIImage(named: "detailsIcon"), for: .normal)
        $0.frame = CGRect(x: cellImage.frame.width - 60, y: 20, width: 31, height: 31)
        
        return $0
    }(UIButton())
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 30
        clipsToBounds = true
        addSubview(cellImage)
        cellImage.addSubview(imageMenuButton)
    }
    
    func configureCell(image: String) {
        cellImage.image = UIImage(named: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
