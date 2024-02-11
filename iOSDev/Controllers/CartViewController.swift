//
//  CartViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 11.02.2024.
//

import UIKit

class CartViewController: UIViewController {

    lazy var emptyCartLabel: UILabel = {
        $0.text = "Корзина пуста"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        return $0
    }(UILabel())

    lazy var goToHomeButton: UIButton = {
        $0.setTitle("Перейти на главную", for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
        return $0
    }(UIButton(type: .system))

    lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 16
        
        return $0
    }(UIStackView(arrangedSubviews: [emptyCartLabel, goToHomeButton]))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemTeal

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func goToHome() {
        if let tabBarVC = self.tabBarController as? TabBarViewController {
            tabBarVC.selectedIndex = 0
        }
    }
}
