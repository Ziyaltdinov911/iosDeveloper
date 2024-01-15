//
//  SceneDelegate.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 11.01.2024.
//

import UIKit

protocol SceneDelegateProtocol {
    func startMainScreen()
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    private var keychainManager = KeychainManager()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = Builder.getPasscodeController(passcodeState: checkIssetPasscode(), sceneDelegate: self)
        window?.makeKeyAndVisible()
    }

    private func checkIssetPasscode() -> PasscodeState {
        let keychainPasscodeResult = keychainManager.load(key: KeychainKeys.passcode.rawValue)
        switch keychainPasscodeResult {
            
        case .success(let code):
            return code.isEmpty ? .setNewPasscode : .inputPasscode
        case .failure:
            return .setNewPasscode
        }
    }


}

extension SceneDelegate: SceneDelegateProtocol {
    func startMainScreen() {
        self.window?.rootViewController = Builder.createTabBarController()
    }
    
    
}
