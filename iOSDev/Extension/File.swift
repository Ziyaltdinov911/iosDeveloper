//
//  UITextField.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 22.02.2024.
//

import UIKit

extension UITextField {
    func setleftOffset() {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 10))
        self.leftViewMode = .always
    }
}
