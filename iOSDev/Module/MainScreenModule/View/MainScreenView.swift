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
    private var topInsets: CGFloat = 0
    
    private var menuViewHeight = UIApplication.topSafeArea + 70
    
    lazy var topMenuView: UIView = {
        $0.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: menuViewHeight)
        $0.backgroundColor = UIColor(named: "mainColor")
        $0.addSubview(menuAppName)
        $0.addSubview(settingsButton)
        return $0
    }(UIView())
    
    lazy var menuAppName: UILabel = {
        $0.text = "SwiftPocket"
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        $0.textColor = .white
        $0.frame = CGRect(x: 50, y: menuViewHeight - 40, width: view.bounds.width, height: 30)
        return $0
    }(UILabel())
    
    lazy var settingsButton: UIButton = {
        $0.frame = CGRect(x: view.bounds.width - 50, y: menuViewHeight - 35, width: 20, height: 20)
        $0.setBackgroundImage(UIImage(systemName: "gearshape"), for: .normal)
        $0.tintColor = .white
        return $0
    }(UIButton())
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 60, height: view.frame.width - 60)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 40, right: 0)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        collectionView.contentInset.top = 130
        collectionView.backgroundColor = UIColor(named: "mainColor")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(MainPostCell.self, forCellWithReuseIdentifier: MainPostCell.reuseId)
        collectionView.register(MainPostCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainPostHeader.reuseId)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "mainColor")
        view.addSubview(collectionView)
        view.addSubview(topMenuView)
        
        topInsets = collectionView.adjustedContentInset.top
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: .hideTabBar, object: nil, userInfo: ["isHide": false])

    }
}

extension MainScreenView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.presenter.posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter.posts?[section].items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPostCell.reuseId, for: indexPath) as? MainPostCell
        else { return UICollectionViewCell() }
        
        if let item = presenter.posts?[indexPath.section].items[indexPath.row] {
            cell.configureCell(item: item)

        }
        
        cell.backgroundColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        collectionView.register(MainPostHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainPostHeader.reuseId)

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainPostHeader.reuseId, for: indexPath) as! MainPostHeader

        header.setHeaderText(header: presenter.posts?[indexPath.section].date.getDateDiference())
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width - 60, height: 40)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let menuTopPostion = scrollView.contentOffset.y + topInsets
        
        if menuTopPostion < 40, menuTopPostion > 0 {
            topMenuView.frame.origin.y = -menuTopPostion
            self.menuAppName.font = UIFont.systemFont(ofSize: 30 - menuTopPostion * 0.2, weight: .bold)
        }
    }
    
}

extension MainScreenView: MainScreenViewProtocol {
    func showPosts() {
        collectionView.reloadData()
    }
    
    
}
