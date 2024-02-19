//
//  LastItemsCell.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 18.02.2024.
//

import UIKit

class LastItemsCell: UICollectionViewCell {

    static let reuseIdentifier = "LastItemsCell"

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

    func setupCell(data: Item) {
        image.image = UIImage(named: data.photo)
    }

    private func setConstraints() {
         NSLayoutConstraint.activate([
             image.topAnchor.constraint(equalTo: topAnchor),
             image.bottomAnchor.constraint(equalTo: bottomAnchor),
             image.leadingAnchor.constraint(equalTo: leadingAnchor),
             image.trailingAnchor.constraint(equalTo: trailingAnchor),
         ])
     }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
