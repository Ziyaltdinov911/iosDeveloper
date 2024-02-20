//
//  DetailsView.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 20.02.2024.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    
}

class DetailsView: UIViewController {
    
    var presenter: DetailsViewPresenterProtocol!
    private var menuViewHeight = UIApplication.topSafeArea + 50
    
    lazy var topMenuView: UIView = {
        $0.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: menuViewHeight)
        $0.backgroundColor = UIColor(named: "mainColor")
        return $0
    }(UIView())
    
    
    lazy var backAction = UIAction { [weak self] _ in
        self?.navigationController?.popViewController(animated: true)
    }
    
    lazy var menuAction = UIAction { [weak self] _ in
        print("Menu open")
    }
    
    lazy var navigationHeader: NavigationHeader = {
        NavigationHeader(backAction: backAction, menuAction: menuAction, date: presenter.item.date)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainColor")
        view.addSubview(topMenuView)
        setupPageHeader()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupPageHeader() {
        let headerView = navigationHeader.getNavigationHeader(type: .back)
        headerView.frame.origin.y = UIApplication.topSafeArea
        
        view.addSubview(headerView)
    }
}

extension DetailsView: DetailsViewProtocol {
    
}
