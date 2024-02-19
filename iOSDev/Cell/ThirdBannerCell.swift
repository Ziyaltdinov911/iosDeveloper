//
//  ThirdBannerCell.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 18.02.2024.
//

import UIKit

class ThirdBannerCell: UICollectionViewCell {

    static let reuseIdentifier = "ThirdBannerCell"

    lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())

    lazy var title: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        addSubview(title)
        backgroundColor = .lightGray
        layer.cornerRadius = 30
        setConstraints()
    }

    func setupCell(data: Item) {
        image.image = UIImage(named: data.photo)
        title.text = data.text
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            image.widthAnchor.constraint(equalToConstant: 70),

            title.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
