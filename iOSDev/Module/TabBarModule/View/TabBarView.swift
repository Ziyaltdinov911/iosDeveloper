//
//  TabBarView.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 15.01.2024.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
    func setControllers(controllers: [UIViewController])
}

class TabBarView: UITabBarController {
    
    var presenter: TabBarViewPresenter!
    private let tabs: [UIImage] = [UIImage(named: "homeBtn")!, UIImage(named: "plusBtn")!, UIImage(named: "favoriteBtn")!]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabs.enumerated().forEach {
            let offsets: [Double] = [-100, 0, 100]
            let tabButton = createTabBarButton(icon: $0.element, tag: $0.offset, offsetX: offsets[$0.offset], isBigButton: $0.offset == 1 ? true : false)
            
            view.addSubview(tabButton)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        selectedIndex = 2
    }
    
    lazy var selectedItem = UIAction { [weak self] sender in
        guard
        let self = self,
        let sender = sender.sender as? UIButton
        else { return }
        
        self.selectedIndex = sender.tag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBar.isHidden = true
    }
    
}

extension TabBarView {
    
    private func createTabBarButton(icon: UIImage, tag: Int, offsetX: Double, isBigButton: Bool = false) -> UIButton {
        return {
            
            let btnSize: Double = isBigButton ? 60 : 25
            $0.frame.size = CGSize(width: btnSize, height: btnSize)
            $0.tag = tag
            
            $0.setBackgroundImage(icon, for: .normal)
            $0.tintColor = .white
            $0.frame.origin = CGPoint(x: .zero, y: view.frame.height - (btnSize + (isBigButton ? 44 : 62)))
            $0.center.x = view.center.x + offsetX
            
            return $0
            
        }(UIButton(primaryAction: selectedItem))
        
    }
}

extension TabBarView: TabBarViewProtocol {
    func setControllers(controllers: [UIViewController]) {
        setViewControllers(controllers, animated: true)
    }
}