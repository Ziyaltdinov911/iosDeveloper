//
// FavoritesViewController.swift
// iOSDev
//
// Created by Камиль Байдиев on 15.03.2024.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {

    private let refreshControl = UIRefreshControl()
    private let realm = try! Realm()
    private var notificationToken: NotificationToken?
    var photos: [Photo] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 300, height: 300)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray
        return collectionView
    }()
    
    var favorites: Results<Note>! {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Избранные"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        navigationController?.navigationBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] = UIColor.white
        view.backgroundColor = .systemGray
        
        view.addSubview(collectionView)
        setupConstraints()

        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
        collectionView.dataSource = self
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshFavorites), for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshFavorites()
    }
    
    @objc private func refreshFavorites() {
        favorites = realm.objects(Note.self)
        photos = favorites.map { note in
            let photo = Photo(id: note.id, urls: PhotoUrl(small: "", full: "", regular: note.photoUrl), description: note.description)
            return photo
        }
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
