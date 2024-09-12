//
//  CatalogViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 11.02.2024.
//

import UIKit

class CatalogViewController: UIViewController {

    var products: [Product] = [
        Product(name: "Yandex", link: "https://www.yandex.ru"),
        Product(name: "Google", link: "https://www.google.com"),
    ]

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        let itemWidth = (view.bounds.width - 30 - 10) / 2 // - Вычисляем ширину элемента с учетом отступов и распределяем по два элемента в ряд

        layout.itemSize = CGSize(width: itemWidth, height: 150)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemTeal
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemTeal
        view.addSubview(collectionView)

        collectionView.frame = CGRect(x: 15, y: 0, width: view.bounds.width - 30, height: view.bounds.height)

        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CatalogViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = products[indexPath.item]
        cell.configure(with: product)
        return cell
    }

}
    
extension CatalogViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.item]

        if let url = URL(string: product.link) {
            let webViewController = WebViewController()
            webViewController.url = url

//            navigationController?.pushViewController(webViewController, animated: true) - for UINAvigation
            
             present(webViewController, animated: true, completion: nil)
        }
    }
}



