//
//  MainScreenView.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 15.01.2024.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    func showPosts()
}

class MainScreenView: UIViewController {
    
    var presenter: MainScreenPresenterProtocol!
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: view.frame.width - 60,
                                 height: view.frame.width - 60)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 40, right: 0)
        
        $0.backgroundColor = UIColor(named: "mainColor")
        $0.dataSource = self
        $0.delegate = self
        $0.alwaysBounceVertical = true
        $0.register(MainPostCell.self, forCellWithReuseIdentifier: MainPostCell.reuseId)
        $0.register(MainPostCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainPostHeader.reuseId)
        
        return $0
        
    }(UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewLayout()))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "mainColor")
        view.addSubview(collectionView)
        // Do any additional setup after loading the view.
    }

}

extension MainScreenView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    
}

extension MainScreenView: MainScreenViewProtocol {
    func showPosts() {
        collectionView.reloadData()
    }
    
    
}
