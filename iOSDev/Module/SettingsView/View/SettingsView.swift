//
//  SettingsView.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 29.02.2024.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    
    var tableView: UITableView { get set }
    
}

class SettingsView: UIViewController, SettingsViewProtocol, SceneDelegateProtocol {
    func startMainScreen() {
         
    }
    
    
    lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.backgroundColor = UIColor(named: "blackColor")
        $0.separatorStyle = .none
        $0.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseId)
        return $0
    }(UITableView(frame: view.bounds, style: .insetGrouped))
    
    
    var presenter: SettingsViewPresenter!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "mainCOlor")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "blackColor")
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        title = "Настройки"
        
        view.backgroundColor = UIColor(named: "blackColor")

    }
    
    

}

extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingsItems.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath) as! SettingsCell
        
        let cellItem = SettingsItems.allCases[indexPath.row]
        cell.cellSetup(cellType: cellItem)
        cell.completion = {
            if indexPath.row == 0 {
                
                let passcodeVC = Builder.getPasscodeController(passcodeState: .setNewPasscode, sceneDelegate: self, isSettings: true)
                
                self.present(passcodeVC, animated: true)
                
//                if let sceneDelegate = UIApplication.shared.delegate as? SceneDelegate {
//                    let passcodeVC = Builder.getPasscodeController(passcodeState: .setNewPasscode, sceneDelegate: sceneDelegate, isSettings: true)
//                    self.present(passcodeVC, animated: true)
//                }
                
            }
            
        }
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell

    }
}
