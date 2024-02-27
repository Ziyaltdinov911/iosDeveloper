//
//  AddPostPhotoCell.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 27.02.2024.
//

import UIKit

class AddPostPhotoCell: UICollectionViewCell, CollectionViewCellProtocol {
    static var reuseId: String = "AddPostPhotoCell"
    
    private lazy var cellImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        
        return $0
    }(UIImageView(frame: bounds))
    
    private lazy var photoRemoveBtn: UIButton = {
        $0.setBackgroundImage(UIImage(named: "closeIcon"), for: .normal)
        return $0
    }(UIButton(frame: CGRect(x: cellImage.frame.width - 30, y: 30, width: 15, height: 15), primaryAction: photoRemoveBtnAction))
    
    private lazy var photoRemoveBtnAction = UIAction { _ in
        print("Remove img")
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cellImage)
        layer.cornerRadius = 30
        clipsToBounds = true
        cellImage.addSubview(photoRemoveBtn)
    }
    
    func setCellImage(image: UIImage) {
        self.cellImage.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
