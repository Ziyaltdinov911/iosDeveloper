//
//  ViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 11.03.2024.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    private let manager = NetworkManager()
    lazy var photos: [Photo]? = []
    private let realm = try! Realm()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return control
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.frame.width - 40, height: self.view.frame.width - 40)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
        collectionView.dataSource = self
        collectionView.addSubview(self.refreshControl)
        return collectionView
    }()
    
    private lazy var favoritesButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Избранное", style: .plain, target: self, action: #selector(showFavorites))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)], for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(collectionView)
        setupConstraints()
        navigationItem.rightBarButtonItem = favoritesButton
        
        print(FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!)
        getNews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteRemoved), name: .favoriteRemoved, object: nil)
    }
    
    private func getNews() {
        manager.getPhotos { [weak self] result in
            switch result {
            case .success(let success):
                self?.photos = success
                self?.collectionView.reloadData()
                self?.refreshControl.endRefreshing()
                self?.showSuccess()
            case .failure(_):
                self?.showError()
            }
        }
    }
    
    @objc private func refreshData() {
        getNews()
    }
    
    @objc private func showFavorites() {
        let favoritesViewController = FavoritesViewController()
        navigationController?.pushViewController(favoritesViewController, animated: true)
    }
    
    func showSuccess() {
        print("Данные успешно")
    }
    
    func showError() {
        print("Ошибка загрузки данных")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func handleFavoriteRemoved() {
        collectionView.reloadData()
    }
}
