//
//  UIView.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 14.01.2024.
//

import UIKit

extension UIView {
   static func configure<T: UIView>(view: T, block: @escaping (T) -> ()) -> T {
       view.translatesAutoresizingMaskIntoConstraints = false
//       view.layer.cornerRadius = 1
       block(view)
       return view
    }
}
