//
//  CollectionData.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 15.02.2024.
//

import Foundation

struct Section {
    var type: String
    var header: String
    var items: [Item]
}

struct Item {
    var name: String
    var text: String
    var photo: String
}

class MockData {
    static func getData() -> [Section] {
        let sectionOneItems = [
            Item(name: "Name1", text: "", photo: "img1"),
            Item(name: "Name2", text: "", photo: "img2"),
            Item(name: "Name3", text: "", photo: "img3"),
            Item(name: "Name4", text: "", photo: "img4"),
            Item(name: "Name5", text: "", photo: "img5"),
            Item(name: "Name1", text: "", photo: "img1"),
            Item(name: "Name2", text: "", photo: "img2"),
            Item(name: "Name3", text: "", photo: "img3"),
            Item(name: "Name4", text: "", photo: "img4"),
            Item(name: "Name5", text: "", photo: "img5"),
        ]

        let sectionSecondItems = [
            Item(name: "Name1", text: "", photo: "img1"),
            Item(name: "Name2", text: "", photo: "img2"),
            Item(name: "Name3", text: "", photo: "img3"),
        ]

        let sectionThreeItems = [
            Item(name: "Name1", text: "Текст ячейки", photo: "img1"),
            Item(name: "Name2", text: "Текст ячейки", photo: "img2"),
            Item(name: "Name3", text: "Текст ячейки", photo: "img3"),
            Item(name: "Name4", text: "Текст ячейки", photo: "img4"),
            Item(name: "Name5", text: "Текст ячейки", photo: "img5"),
        ]

        let sectionOne = Section(type: "story", header: "", items: sectionOneItems)
        let sectionSecond = Section(type: "friends", header: "Friends", items: sectionSecondItems)
        let sectionThree = Section(type: "items", header: "Items Section", items: sectionThreeItems)

        let itemsSections = Section(type: "itemsSections", header: "Items Sections", items: [
            Item(name: "Item1", text: "Some text", photo: "img1"),
            Item(name: "Item2", text: "Some text", photo: "img2"),
            Item(name: "Item3", text: "Some text", photo: "img3"),
        ])

        return [sectionOne, sectionSecond, sectionThree, itemsSections]
    }
}
