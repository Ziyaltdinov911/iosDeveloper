//
//  FavoriteManager.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 14.03.2024.
//

import Foundation
import RealmSwift

class FavoriteManager {
    
    static let shared = FavoriteManager()
    
    private let realm = try! Realm()
    
    func addToFavorites(photo: Photo) {
        let note = Note()
        note.id = photo.id
        note.header = "Photo"
        note.photoUrl = photo.urls.regular
        try! realm.write {
            realm.add(note, update: .modified)
        }
    }

    func removeFromFavorites(photo: Photo) {
        if let note = realm.object(ofType: Note.self, forPrimaryKey: photo.id) {
            try! realm.write {
                realm.delete(note)
            }
        }
    }
    
    func isFavorite(photo: Photo) -> Bool {
        return realm.object(ofType: Note.self, forPrimaryKey: photo.id) != nil
    }
    
    func getFavorites() -> Results<Note> {
        return realm.objects(Note.self)
    }
}
