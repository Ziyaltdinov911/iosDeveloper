//
//  ProductCell.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 11.02.2024.
//

import UIKit

class ProductCell: UICollectionViewCell {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let linkLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let contentViewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, linkLabel])
        stackView.axis = .vertical

        contentViewBackground.addSubview(stackView)
        addSubview(contentViewBackground)

        contentViewBackground.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

        stackView.frame = CGRect(x: 8, y: 8, width: contentViewBackground.frame.width - 16, height: contentViewBackground.frame.height - 16)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentViewBackground.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        linkLabel.preferredMaxLayoutWidth = linkLabel.frame.size.width
    }

    func configure(with product: Product) {
        nameLabel.text = product.name
        linkLabel.text = product.link
    }
}
