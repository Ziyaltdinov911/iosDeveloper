//
//  PhotoCell.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 11.03.2024.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
    
    static let reuseID = "PhotoCell"
    
    private lazy var imageView: UIImageView = {
        $0.backgroundColor = .gray
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.image = UIImage(systemName: "slowmo")
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var likeButton: UIButton = {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let descriptionLabel: UILabel = {
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    private var photo: Photo?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(likeButton)
        addSubview(descriptionLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        descriptionLabel.text = nil
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .white
    }

    
    func configure(with photo: Photo) {
        self.photo = photo
        let description = photo.description ?? "Нет описания"
        descriptionLabel.text = description
        imageView.sd_setImage(with: URL(string: photo.urls.regular), placeholderImage: nil, options: [], completed: nil)
        updateLikeButtonState()
    }
    
    @objc private func likeButtonTapped() {
        guard let photo = photo else { return }
        if FavoriteManager.shared.isFavorite(photo: photo) {
            FavoriteManager.shared.removeFromFavorites(photo: photo)
        } else {
            FavoriteManager.shared.addToFavorites(photo: photo)
        }
        updateLikeButtonState()
    }
    
    private func updateLikeButtonState() {
        guard let photo = photo else { return }
        if FavoriteManager.shared.isFavorite(photo: photo) {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .white
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            likeButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10),
            likeButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            likeButton.widthAnchor.constraint(equalToConstant: 60),
            likeButton.heightAnchor.constraint(equalToConstant: 60),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }

}
