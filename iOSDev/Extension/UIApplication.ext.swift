//
//  UIApplication.ext.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 19.02.2024.
//

import UIKit

extension UIApplication {
    static var topSafeArea: CGFloat {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first?.safeAreaInsets.top ?? .zero
    }
}
