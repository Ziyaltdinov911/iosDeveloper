//
//  DataBaseManager.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 20.03.2024.
//

import Foundation
import RealmSwift

class DataBaseManager{
    let realm = try! Realm()
    
    var folders = [Folder]()
    
    init(){
        getFolder()
    }
    
    func createFolder(folder: Folder) {
        try! realm.write{
            realm.add(folder)
        }
        getFolder()
    }
    
    
    func createNote(folder: Folder, note: Note) {
        try! realm.write{
            folder.notes.append(note)
        }
    }
    
    
    //Read
    func getNotes() -> [Note]{
        let allNotes = realm.objects(Note.self)
        return Array(allNotes)
    }
    
    
    func getFolder(){
        let allFolder = realm.objects(Folder.self)
        self.folders =  Array(allFolder)
    }
    
    
    //Update
    func updateNote(id: String, header: String){
        if let note = realm.object(ofType: Note.self, forPrimaryKey: id) {
            try! realm.write{
                note.header = header
            }
        }
    }
    
    //Delete
    func deleteNote(id: String){
        if let note = realm.object(ofType: Note.self, forPrimaryKey: id) {
            try! realm.write{
                realm.delete(note)
            }
        }
    }
    
    func deleteFolder(id: String) {
        if let folder = realm.object(ofType: Folder.self, forPrimaryKey: id) {
            
            folder.notes.forEach { note in
                self.deleteNote(id: note.id)
            }
            
            try! realm.write{
                realm.delete(folder)
            }
            
            
        }
        getFolder()
    }
}

