//
//  ArticleModel.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 06.03.2024.
//

import Foundation
import UIKit

struct NewsArticle: Codable {
    let source: NewsSource
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}

