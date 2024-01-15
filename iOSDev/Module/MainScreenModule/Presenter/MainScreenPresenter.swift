//
//  MainScreenPresenter.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 15.01.2024.
//

import UIKit

protocol MainScreenPresenterProtocol: AnyObject {
    init(view: MainScreenViewProtocol) // StoryManager?
}

class MainScreenPresenter {
    
    weak var view: MainScreenViewProtocol?
    
    required init(view: MainScreenViewProtocol) {
        self.view = view
    }
}

extension MainScreenPresenter: MainScreenPresenterProtocol {
    
}
