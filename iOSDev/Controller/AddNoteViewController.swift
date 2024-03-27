//
//  AddNoteViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 20.03.2024.
//

import UIKit
import Alamofire

class AddNoteViewController: UIViewController {
    let manager = DataBaseManager()
    let storageManager = StorageManager()
    
    var photos = [Photo]()
    
    private lazy var addBtn: UIBarButtonItem = {
        return $0
    }(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote)))
    
    private lazy var picker: UIImagePickerController = {
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        $0.delegate = self
        return $0
    }(UIImagePickerController())
    
    var folder: Folder?
    
    private lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.delegate = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = addBtn
        title = "Заметки"
        view.addSubview(tableView)
        tableView.frame = view.bounds // Размеры таблицы
        tableView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    
    @objc
    func addNote(){
        
        let alertController = UIAlertController(title: "Выберите источник фото", message: nil, preferredStyle: .actionSheet)
        
        let galleryAction = UIAlertAction(title: "Галерея", style: .default) { _ in
            self.presentImagePicker(sourceType: .photoLibrary)
        }
        alertController.addAction(galleryAction)
        
        let unsplashAction = UIAlertAction(title: "Unsplash", style: .default) { _ in
            self.addRandomPhotos()
        }
        alertController.addAction(unsplashAction)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    func addRandomPhotos() {
       
        storageManager.getPhotos { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                if let photos = photos {
                    DispatchQueue.main.async {
                        for photo in photos {
                            let note = Note()
                            note.header = "Image"
                            note.photoUrl = photo.urls.regular
                            if let folder = self.folder {
                                self.manager.createNote(folder: folder, note: note)
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }

    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        picker.sourceType = sourceType
        present(picker, animated: true, completion: nil)
    }

}

extension AddNoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let photoName = UUID().uuidString + ".jpeg"
        
        if let img = info[.editedImage] as? UIImage {
            let note = Note()
            note.header = "Image"
            note.photoUrl = photoName
            
            self.manager.createNote(folder: folder!, note: note)
            if let imgData = img.jpegData(compressionQuality: 1) {
                self.storageManager.saveImage(data: imgData, name: photoName, folderName: folder!.name)
            }
        }
        
        self.tableView.reloadData()
        picker.dismiss(animated: true)
    }
}
