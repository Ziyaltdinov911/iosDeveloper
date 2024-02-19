//
//  ListCell.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 15.02.2024.
//

import UIKit

class SecondBannerCell: UICollectionViewCell {

    lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        backgroundColor = .lightGray
        layer.cornerRadius = 30
        setConstraints()
    }

    func setupCell(data: Item?) {
        if let item = data {
            image.image = UIImage(named: item.photo)
        } else {
            image.image = UIImage(named: "img1")
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
