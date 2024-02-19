//
//  ViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 11.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionData = MockData.getData()
    
    lazy var collectionView: UICollectionView = {
        $0.register(FirstStoryCell.self, forCellWithReuseIdentifier: "StoryCell")
        $0.register(SecondBannerCell.self, forCellWithReuseIdentifier: "SecondImageViewCell")
        $0.register(ThirdBannerCell.self, forCellWithReuseIdentifier: "ThirdBannerCell")
        $0.register(LastItemsCell.self, forCellWithReuseIdentifier: "LastItemsCell")
        
        $0.dataSource = self
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: createSectionLayout()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }
    
    private func createSectionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, _ in
            switch section {
            case 0:
                return self.createStorySection()
            case 1:
                return self.createSecondBanner()
            case 2:
                return self.createThirdItemsSection()
            default:
                return self.createLastItemsSection()
            }
        }
    }

    // Первые элементы
    private func createStorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(90), 
                                              heightDimension: .absolute(90))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), 
                                               heightDimension: .absolute(100))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        return section
    }
    // Вторые элементы
    private func createSecondBanner() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), 
                                              heightDimension: .fractionalHeight(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), 
                                               heightDimension: .fractionalHeight(0.5))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: -300, trailing: 10)
        
        return section
    }
    // Третьи элементы
    private func createThirdItemsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), 
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), 
                                               heightDimension: .estimated(100))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item, item, item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 10, bottom: 30, trailing: 10)
        return section
    }
    // Последние элементы
    private func createLastItemsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item, item, item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        return section
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionData[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondImageViewCell", for: indexPath) as! SecondBannerCell
            let item = collectionData[indexPath.section].items[indexPath.item]
            cell.setupCell(data: item)
            return cell

        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdBannerCell", for: indexPath) as! ThirdBannerCell
            let item = collectionData[indexPath.section].items[indexPath.item]
            cell.setupCell(data: item)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastItemsCell", for: indexPath) as! LastItemsCell
            let item = collectionData[indexPath.section].items[indexPath.item]
            cell.setupCell(data: item)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as! FirstStoryCell
            let itemPhoto = collectionData[indexPath.section].items[indexPath.item].photo
            cell.setCell(imageName: itemPhoto)
            return cell
        }
    }
}
