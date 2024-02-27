//
//  AddPostPresenter.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 27.02.2024.
//

import UIKit

protocol AddPostPresenterProtocol: AnyObject {
    init(view: AddPostViewProtocol, photos: [UIImage])
    var photos: [UIImage] { get set }
    var tags: [String] { get set }
}

class AddPostPresenter: AddPostPresenterProtocol {

    private weak var view: AddPostViewProtocol?
    
    var photos: [UIImage]
    
    var tags: [String] = ["Nature", "Work", "Education"]
    
    required init(view: AddPostViewProtocol, photos: [UIImage]) {
        self.photos = photos
        self.view = view
    }
    
    
}
