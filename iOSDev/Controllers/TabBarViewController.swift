//
//  TabBarViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 11.02.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = MainViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), tag: 0)
        
        let catalogVC = CatalogViewController()
        catalogVC.tabBarItem = UITabBarItem(title: "Каталог", image: UIImage(systemName: "list.bullet"), tag: 1)

        let cartVC = CartViewController()
        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), tag: 2)

        viewControllers = [homeVC, catalogVC, cartVC]

        setupFrames()
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black

    }

    private func setupFrames() {
        let tabBarHeight: CGFloat = 50.0
        
        for viewController in viewControllers ?? [] {
            if let navigationController = viewController as? UINavigationController,
               let rootViewController = navigationController.viewControllers.first {
                rootViewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - tabBarHeight)
            } else {
                viewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - tabBarHeight)
            }
        }

        tabBar.frame = CGRect(x: 0, y: view.bounds.height - tabBarHeight, width: view.bounds.width, height: tabBarHeight)
    }
}
