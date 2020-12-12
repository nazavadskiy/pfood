//
//  MenuCollectionViewCell.swift
//  Main Project
//
//  Created by Тимур Бакланов on 04.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    let itemStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        return imageView
    }()
        
    let itemButton: UIButton = {
        let button = UIButton()
        button.setTitle("Test", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.sizeToFit()
        button.titleLabel?.textAlignment = .center
        button.titleLabel!.adjustsFontSizeToFitWidth = false
        if #available(iOS 13.0, *) {
            button.backgroundColor = .systemGray5
             button.setTitleColor(UIColor(named: "mainColor"), for: .normal)
        } else {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
        }
        return button
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(itemStack)
        setUpStack()
        itemStack.addArrangedSubview(itemImageView)
        itemStack.addArrangedSubview(itemButton)
        
        itemButton.translatesAutoresizingMaskIntoConstraints = false
        itemButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        backgroundColor = .clear
        layer.cornerRadius = 12
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        if #available(iOS 13.0, *) {
            layer.shadowColor = UIColor.systemGray.cgColor
        } else {
            layer.shadowColor = UIColor.gray.cgColor
        }

        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Handlers
    func setUpStack() {
        itemStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        itemStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        itemStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        itemStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
