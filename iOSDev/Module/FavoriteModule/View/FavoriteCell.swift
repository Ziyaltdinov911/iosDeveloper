//
//  FavoriteCell.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 20.02.2024.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    static let reuseID = "FavoriteCell"
    
    lazy var postImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: bounds))
    
    lazy var remoteInFavoriteButton: UIButton = {
        $0.frame = CGRect(x: bounds.width - 43, y: 21, width: 25, height: 25)
        $0.setBackgroundImage(UIImage(named: "favoriteBtnBlack"), for: .normal)
        return $0
    }(UIButton(primaryAction: nil))
    
    lazy var dateView: UIView = {
        $0.frame = CGRect(x: 10, y: bounds.height - 47, width: bounds.width - 20, height: 27)
        $0.backgroundColor = UIColor(white: 1, alpha: 0.4)
        $0.layer.cornerRadius = 14
        $0.addSubview(dateLabel)
        return $0
    }(UIView())
    
    lazy var dateLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .white
        $0.frame = CGRect(x: 0, y: 0, width: bounds.width - 20, height: 27)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [postImage, remoteInFavoriteButton, dateView].forEach {
            addSubview($0)
        }
        
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    func configureCell(item: PostItem) {
        postImage.image = UIImage(named: item.photos.first!)
        dateLabel.text = item.date.formattDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
