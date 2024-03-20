//
// PhotoCell.swift
// iOSDev
//
// Created by Камиль Байдиев on 11.03.2024.
//

import UIKit
import SDWebImage
import RealmSwift

class PhotoCell: UICollectionViewCell {
    
    static let reuseID = "PhotoCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(systemName: "slowmo")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeButton.tintColor = .white
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return likeButton
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private var photo: Note?
    private let realm = try! Realm()
    
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
        let note = Note()
        note.id = photo.id
        note.header = photo.description ?? "Нет описания"
        note.photoUrl = photo.urls.regular
        
        self.photo = note
        let description = photo.description ?? "Нет описания"
        descriptionLabel.text = description
        imageView.sd_setImage(with: URL(string: photo.urls.regular), placeholderImage: nil, options: [], completed: nil)
        updateLikeButtonState()
    }
    
    @objc private func likeButtonTapped() {
        guard let photo = photo else { return }
        try! realm.write {
            if let existingNote = realm.objects(Note.self).filter("id == %@", photo.id).first {
                realm.delete(existingNote)
            } else {
                let note = Note()
                note.id = photo.id
                note.header = photo.header
                note.photoUrl = photo.photoUrl
                realm.add(note)
            }
        }
        NotificationCenter.default.post(name: .favoriteRemoved, object: nil)
        updateLikeButtonState()
    }


    
    private func updateLikeButtonState() {
        guard let photo = photo else { return }
        let isFavorite = !realm.objects(Note.self).filter("id == %@", photo.id).isEmpty
        if isFavorite {
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
