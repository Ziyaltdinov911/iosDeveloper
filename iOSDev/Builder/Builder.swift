//
//  Builder.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 14.01.2024.
//

import UIKit

protocol BuilderProtocol {
    static func getPasscodeController(passcodeState: PasscodeState, sceneDelegate: SceneDelegateProtocol) -> UIViewController
    static func createTabBarController() -> UIViewController
    
    //VC
    
    static func createMainScreenController() -> UIViewController
    static func createCameraScreenController() -> UIViewController
    static func createFavoriteScreenController() -> UIViewController


}

class Builder: BuilderProtocol {
    static func getPasscodeController(passcodeState: PasscodeState, sceneDelegate: SceneDelegateProtocol) -> UIViewController {
        let passcodeView = PasscodeView()
        let keychainManager = KeychainManager()

        let presenter = PasscodePresenter(view: passcodeView, passcodeState: passcodeState, keychainManager: keychainManager, sceneDelegate: sceneDelegate)
        
        passcodeView.passcodePresenter = presenter
        return passcodeView
        
    }
    
    static func createTabBarController() -> UIViewController {
        let tabBarView = TabBarView()
        let presenter = TabBarViewPresenter(view: tabBarView)
        tabBarView.presenter = presenter
        
        return tabBarView
    }
    
    static func createMainScreenController() -> UIViewController {
        let mainView = MainScreenView()
        let presenter = MainScreenPresenter(view: mainView)
        mainView.presenter = presenter
        return mainView
    }
    
    static func createCameraScreenController() -> UIViewController {
        let cameraView = CameraView()
        let cameraService = CameraService()
        let presenter = CameraViewPresenter(view: cameraView, cameraService: cameraService)
        
        cameraView.presenter = presenter
        
        return UIImagePickerController(rootViewController: cameraView)
    }
    
    static func createFavoriteScreenController() -> UIViewController {
        let favoriteView = FavoriteView()
        let presenter = FavoriteViewPresenter(view: favoriteView)
        
        
        favoriteView.presenter = presenter
        
        return UINavigationController(rootViewController: favoriteView)
    }
    
    static func createDetailsController(item: PostItem) -> UIViewController {
        let detailsView = DetailsView()
        let presenter = DetailsViewPresenter(view: detailsView, item: item)
        
        detailsView.presenter = presenter
        
        return detailsView
    }
    
    static func createPhotoViewController(image: UIImage?) -> UIViewController {
        let photoView = PhotoView()
        let presenter = PhotoViewPresenter(view: photoView, image: image)
        
        photoView.presenter = presenter
        
        return photoView
    }
    
    static func createAddPostViewController(photos: [UIImage]) -> UIViewController {
        let addPostView = AddPostView()
        let presenter = AddPostPresenter(view: addPostView, photos: photos)
        
        addPostView.presenter = presenter
        
        return addPostView
    }
    
}



