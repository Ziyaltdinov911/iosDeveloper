//
//  StoryCell.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 15.02.2024.
//

import UIKit

class FirstStoryCell: UICollectionViewCell {

    lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        setConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        image.layer.cornerRadius = bounds.width / 2
    }

    func setCell(imageName: String?) {
        if let imageName = imageName {
            self.image.image = UIImage(named: imageName)
        } else {
            self.image.image = UIImage(named: "img1")
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
