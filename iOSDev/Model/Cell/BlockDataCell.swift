//
//  BlockDataCell.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 06.03.2024.
//

import Foundation
import UIKit

//MARK: - BlockTableViewCell

class BlockDataCell: UITableViewCell {
    
    private let cellBackground: UIView = {
        $0.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        $0.layer.cornerRadius = 15
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let titleLabel: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let mainTextLabel: UITextView = {
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.backgroundColor = .clear
        $0.textContainer.maximumNumberOfLines = 4
        $0.textContainer.lineBreakMode = .byTruncatingTail
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextView())
    
    private let blockImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(cellBackground)
        cellBackground.addSubview(titleLabel)
        cellBackground.addSubview(mainTextLabel)
        cellBackground.addSubview(blockImageView)
        
        //MARK: - Elements constraints
        
        NSLayoutConstraint.activate([
            
            // Cell Background constraints
            cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cellBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // ImageView constraints
            blockImageView.topAnchor.constraint(equalTo: cellBackground.topAnchor),
            blockImageView.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor),
            blockImageView.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor),
            blockImageView.heightAnchor.constraint(equalTo: cellBackground.widthAnchor),
            
            // TitleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: blockImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: blockImageView.leadingAnchor, constant: 34),
            titleLabel.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -20),
            
            // MainTextLabel constraints
            mainTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            mainTextLabel.leadingAnchor.constraint(equalTo: blockImageView.leadingAnchor),
            mainTextLabel.trailingAnchor.constraint(equalTo: blockImageView.trailingAnchor),
            mainTextLabel.bottomAnchor.constraint(equalTo: cellBackground.bottomAnchor, constant: -20),
        ])
    }
    
    func configure(with data: NewsArticle) {
        titleLabel.text = data.title
        mainTextLabel.text = data.description
        print("Данные получены")

        if let imageUrlString = data.urlToImage,
          let imageUrl = URL(string: imageUrlString) {
            blockImageView.load(url: imageUrl)
            print("Изображение получено\n")
        } else {
            blockImageView.image = UIImage(named: "scrollViewImg")
            print("Изображение не получено. Установлено дефолтное изображение\n")
        }
    }
    
}
