//
//  RegistrationView.swift
//  Main Project
//
//  Created by Тимур Бакланов on 05.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class RegistrationView: UIView {
    
    //MARK: - Creating UI elements
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    let name: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя пользователя"
        if #available(iOS 13.0, *) {
            textField.backgroundColor = .systemBackground
            textField.textColor = UIColor(named: "mainColor")
        } else {
            textField.backgroundColor = .white
            textField.textColor = .black
        }
        textField.borderStyle = .roundedRect
        textField.contentHorizontalAlignment = .center
        textField.textContentType = .emailAddress
        textField.font = .systemFont(ofSize: 18)
        return textField
    }()
    
     let adress: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Адрес"
        if #available(iOS 13.0, *) {
            textField.backgroundColor = .systemBackground
            textField.textColor = UIColor(named: "mainColor")
        } else {
            textField.backgroundColor = .white
            textField.textColor = .black
        }
        textField.borderStyle = .roundedRect
        textField.contentHorizontalAlignment = .center
        textField.font = .systemFont(ofSize: 18)
        return textField
    }()
    
    public let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel!.textColor = .white
        button.backgroundColor = .orange
        return button
    }()
    
    public let logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel!.textColor = .white
        button.backgroundColor = .orange
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stack)
        stack.addArrangedSubview(name)
        stack.addArrangedSubview(adress)
        stack.addArrangedSubview(loginButton)
        setStackConstraints()
        name.setBottomBorder()
        adress.setBottomBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Constraints
    func setStackConstraints() {
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    
}
