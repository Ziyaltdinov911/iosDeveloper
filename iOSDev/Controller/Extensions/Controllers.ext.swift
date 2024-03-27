//
//  Controllers.ext.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 27.03.2024.
//

import UIKit
import Alamofire

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let folder = manager.folders[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = folder.name
        config.secondaryText = "Количество фоток - \(folder.notes.count)"
        config.image = UIImage(systemName: "folder.fill")
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folder = manager.folders[indexPath.row]
        let addVC = AddNoteViewController()
        addVC.folder = folder
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            manager.deleteFolder(id: manager.folders[indexPath.row].id)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension AddNoteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folder?.notes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let folder = folder else { return cell }
        
        let note = Array(folder.notes)
        let oneNote = note[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        
        if let imageData = storageManager.getImage(imgName: oneNote.photoUrl, folderName: folder.name),
           let image = UIImage(data: imageData) {
            config.image = image
            config.imageProperties.reservedLayoutSize = .init(width: 300, height: 300)
            config.imageProperties.maximumSize = .init(width: 300, height: 300)

        } else if let unsplashUrl = URL(string: oneNote.photoUrl) {
            AF.request(unsplashUrl).responseData { response in
                switch response.result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            config.image = image
                            cell.contentConfiguration = config
                        }
                    }
                case .failure(let error):
                    print("Ошибка загрузки фото из Unsplash: \(error.localizedDescription)")
                }
            }
        }
        
        cell.contentConfiguration = config
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let folder = folder else { return }
        
        let note = Array(folder.notes)
        let oneNote = note[indexPath.row]
        
        if editingStyle == .delete {
            self.manager.deleteNote(id: oneNote.id)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
