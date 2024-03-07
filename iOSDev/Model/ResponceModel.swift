//
//  ResponceModel.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 06.03.2024.
//

import Foundation

struct ResponceModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsArticle]
}



