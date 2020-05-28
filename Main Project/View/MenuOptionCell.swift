//
//  MenuOptionCell.swift
//  Main Project
//
//  Created by Тимур Бакланов on 04.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {
    
    //MARK: - Properties
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        if #available(iOS 13.0, *) {
            imageView.tintColor = UIColor(named: "mainColor")
        } else {
            imageView.tintColor = .black
        }
        return imageView
    }()
    
     let menuOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        
        label.text = "test"
        if #available(iOS 13.0, *) {
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.textColor = .black
        }
        return label
    }()
    
    //MARK: - Init

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    fileprivate func setUpIconImageView() {
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
    fileprivate func setUpLabel() {
        menuOptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
        menuOptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        menuOptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 12).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        self.addSubview(iconImageView)
        setUpIconImageView()
        
        self.addSubview(menuOptionLabel)
        setUpLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}
