//
//  Note.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 15.03.2024.
//

import Foundation
import RealmSwift

class Note: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var header: String = ""
    @Persisted var photoUrl: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
