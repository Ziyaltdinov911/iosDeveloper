//
//  StringProtocol.ext.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 15.01.2024.
//

import UIKit

extension StringProtocol {
    var digits: [Int] { compactMap(\.wholeNumberValue) }
}
