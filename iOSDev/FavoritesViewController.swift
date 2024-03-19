//
//  FavoritesViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 15.03.2024.
//

import UIKit

class FavoritesViewController: UIViewController {

    private let refreshControl = UIRefreshControl()
    
    private lazy var collectionView: UICollectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 300, height: 300)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGray
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout()))

    lazy var favorites: [Photo] = [] {
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
        favorites = FavoriteManager.shared.getFavorites()
        refreshFavorites()
    }
    
    @objc private func refreshFavorites() {
        favorites = FavoriteManager.shared.getFavorites()
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

