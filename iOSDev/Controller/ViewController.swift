//
//  ViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 20.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let manager = DataBaseManager()
    
    private lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.delegate = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return $0
    }(UITableView(frame: view.bounds, style: .insetGrouped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Категории"
        view.addSubview(tableView)
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFolder))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addFolder() {
        let alertController = UIAlertController(title: "Добавить папку", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Название папки"
        }
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let folderName = alertController.textFields?.first?.text, !folderName.isEmpty else {
                self.showAlert(message: "Введите название папки")
                return
            }
            
            let folder = Folder()
            folder.name = folderName
            self.manager.createFolder(folder: folder)
            
            self.tableView.reloadData()
        }
        alertController.addAction(addAction)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

