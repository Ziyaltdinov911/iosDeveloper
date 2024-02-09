//
//  Data.ext.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 09.02.2024.
//

import UIKit

extension Date {
    func getDateDiference() -> String {
        let currentDataInterval = Int(Date().timeIntervalSinceReferenceDate)
        let dataDifferences = Double(currentDataInterval - Int(self.timeIntervalSinceReferenceDate))
        let dataDifferencesDate = Int(round(dataDifferences/86400))
        
        switch dataDifferencesDate {
        case 0:
            return "Сегодня"
        case 1:
            return "Вчера"
        case 2...4:
            return "\(dataDifferencesDate) дня назад"
            
        default:
            return "\(dataDifferencesDate) дней назад"
        }
    }
}
