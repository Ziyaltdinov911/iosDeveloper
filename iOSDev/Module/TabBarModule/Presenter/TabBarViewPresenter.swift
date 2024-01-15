//
//  TabBarViewPresenter.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 15.01.2024.
//

import UIKit

protocol TabBarViewPresenterProtocol: AnyObject {
    init(view: TabBarViewProtocol)
//    var tabs: [UIImage] { get set }
    
    func buildTabBar()
}

class TabBarViewPresenter {
    
    weak var view: TabBarViewProtocol?
    
    required init(view: TabBarViewProtocol) {
        self.view = view
        self.buildTabBar()
    }
    
    //    var tabs: [UIImage] = [UIImage(named: "homeBtn")!, UIImage(named: "plusBtn")!, UIImage(named: "favoriteBtn")!]
}

extension TabBarViewPresenter: TabBarViewPresenterProtocol {

    func buildTabBar() {
        let mainScreen = Builder.createMainScreenController()
        let cameraScreen = Builder.createCameraScreenController()
        let favoriteScreen = Builder.createFavoriteScreenController()
        
        self.view?.setControllers(controllers: [mainScreen, cameraScreen, favoriteScreen])
    }
}
