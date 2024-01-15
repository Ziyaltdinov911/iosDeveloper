//
//  PostItem.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 15.01.2024.
//

import Foundation

class PostDate: Identifiable {
    let id = UUID().uuidString
    let items: [PostItem]
    let date: Date
    
    init(items: [PostItem], date: Date) {
        self.items = items
        self.date = date
    }
    
    static getMackData() -> [PostDate] {
        [
        
            PostDate items: [
            PostItem (photos: ["'img1",
            "img2"], comments: nil, tags: ["Дом", "Nature"],
            description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit", isFavorite: false),
            PostItem(photos: ["img3"], comments: nil, tags: ["Nature", "Home", "Education"
            "Work"
            "Game"], description: "tempor incididunt ut labore et dolore magna
            aliqua. Ut enim ad minim veniam", isFavorite: false),
            PostItem (photos: ["img3"],
            "Work"
            comments: nil, tags: ["Nature", "Home", "Education"
            "Game"], description: "tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam" , isFavorite: false)
            J, date: Date()), PostDate (items: [
            PostItem(photos: ["'img2"], comments: nil, tags: ["Nature", "Home", "Education"
            "Work" veniam",
            "Game"], description: "labore et dolore magna aliqua. Ut enim ad minim , isFavorite: false),
            PostItem (photos: ["img3"], comments: nil, tags: ["Nature", "Home",
            "Education"
            "Work"
            "Game"], description: "Ut enim ad minim veniam tempor incididunt ut labore et dolore magna aliqua" 1, date: Date() . addingTimeInterval(-86400)),
            isfavorite: false),
            PostDate (items: [
            PostItem (photos: (" img2",
            "Education"
            "Work"
            "img3"], comments: nil, tags: ["Nature", "Home",
            isFavorite: false),
            "Game"], description: "labore et dolore magna aliqua"
            PostItem(photos: [" img3"], comments: nil, tags: ['Nature", "Home"
            "Education"
            1
            "Work"
            "Game"], description:
            "labore et veniam tempor incididunt ut labore et
            dolore magna aliqua dolore magna aliqua" , isFavorite: false), date: Date ).addingTimeInterval (-172800))
            
        ]
        
    }
}

class PostItem: Identifiable {
    let id = UUID().uuidString
    let photos: [String]
    let comments: [Comment]?
    let tag: [String]?
    let description: String?
    let isFavorite: Bool = false
    
    init(photos: [String], comments: [Comment]?, tag: [String]?, description: String?) {
        self.photos = photos
        self.comments = comments
        self.tag = tag
        self.description = description
    }
}

class Comment: Identifiable {
    let id = UUID().uuidString
    let date: Date
    let comment: String
    
    init(date: Date, comment: String) {
        self.date = date
        self.comment = comment
    }
}
