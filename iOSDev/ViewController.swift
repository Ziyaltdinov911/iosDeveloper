//
//  ViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 11.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let manager = NetworkManager()
    lazy var photos: [Photo]? = []
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        $0.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return $0
    }(UIRefreshControl())
    
    private lazy var collectionView: UICollectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.frame.width - 40, height: self.view.frame.width - 40)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
        $0.dataSource = self
        $0.addSubview(self.refreshControl)
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout()))
    
//    lazy var collectionView: UICollectionView = {
//        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: view.frame.width - 40, height: view.frame.width - 40)
//        
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
//        
//        $0.dataSource = self
//        $0.backgroundColor = .clear
//        $0.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
//        $0.addSubview(refreshControl)
//        return $0
//    }(UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout()))
    
    private lazy var favoritesButton: UIBarButtonItem = {
        $0.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)], for: .normal)
        return $0
    }(UIBarButtonItem(title: "Избранное", style: .plain, target: self, action: #selector(showFavorites)))

    
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
        print("error")
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
