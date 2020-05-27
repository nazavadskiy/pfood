//
//  UserProfileInMenu.swift
//  Main Project
//
//  Created by Тимур Бакланов on 04.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class UserProfileInMenu: UIView {
    
    //MARK: - Properties
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.backgroundColor = .orange
        return image
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "test"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.lineBreakMode = .byTruncatingTail
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    let labelsStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.axis = .vertical
        return stack
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImage)
        addSubview(labelsStack)
        setUpProfileImage()
        setUpLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Handlers
    func setUpProfileImage() {
        profileImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        profileImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setUpLabels() {
        labelsStack.addArrangedSubview(nameLabel)
        labelsStack.addArrangedSubview(phoneNumberLabel)
        
        labelsStack.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: 12).isActive = true
        labelsStack.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor).isActive = true
        labelsStack.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -10).isActive = true
    }

}
