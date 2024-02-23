//
//  PhotoViewPresenter.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 23.02.2024.
//

import UIKit

protocol PhotoViewPresenterProtocol: AnyObject{
    init(view: PhotoViewProtocol, image: UIImage?)
    var image: UIImage? { get set }
}

class PhotoViewPresenter: PhotoViewPresenterProtocol{
    
    var image: UIImage?
    private weak var view: PhotoViewProtocol?
    
    required init(view: PhotoViewProtocol, image: UIImage?) {
        self.image = image
        self.view = view
    }
    
    
}
