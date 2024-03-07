//
//  MainViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 11.01.2024.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate {

    // MARK: - NewsArray

    var newsArray: [NewsArticle] = []
    let networkManager = NetworkManager()

    private let tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UITableView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupNavigation()
        setupTableView()

        networkManager.getNews(q: "iPhone") { [weak self] newsArray in
            DispatchQueue.main.async {
                self?.newsArray = newsArray ?? []
                self?.tableView.reloadData()
            }
        }
    }

    private func setupNavigation() {
        title = "Новости"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(BlockDataCell.self, forCellReuseIdentifier: "blockCell")

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

//MARK: - Extensions

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "blockCell", for: indexPath) as! BlockDataCell
        let newsArticle = newsArray[indexPath.row]
        cell.configure(with: newsArticle)

        return cell
    }
}
