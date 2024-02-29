//
//  SettingsViewPresenter.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 29.02.2024.
//

import Foundation

protocol SettingsViewPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol)
}


class SettingsViewPresenter {
    private weak var view: SettingsViewProtocol?
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
    
}
