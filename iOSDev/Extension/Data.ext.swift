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
    
    func formattDate(formatType: DateFormatType = .full) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru")
        
        switch formatType {
        case .full:
            formatter.dateFormat = "dd MMMM yyyy"
        case .onlyDate:
            formatter.dateFormat = "dd MMMM"
        case .onlyYear:
            formatter.dateFormat = "yyyy"
        }
        
        return formatter.string(from: self)
    }
    
}

enum DateFormatType {
    case full, onlyDate, onlyYear
}
