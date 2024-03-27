//
//  Note.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 20.03.2024.
//

import Foundation
import RealmSwift

class Folder: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name = String()
    @Persisted var folderDescription = String()
    @Persisted var notes: List<Note>
}


class Note: Object{
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var header = String()
    @Persisted var photoUrl = String()
    @Persisted var date = Date()
}

