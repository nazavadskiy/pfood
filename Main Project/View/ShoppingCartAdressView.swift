//
//  ShoppingCartAdressView.swift
//  Main Project
//
//  Created by Тимур Бакланов on 08.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class ShoppingCartAdressView: UIView {

  let adressStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    let adressPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Адрес доставки"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let adressTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Введите адрес доставки"
        textField.font = .systemFont(ofSize: 18)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(adressStackView)
        setUpStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpStack() {
        adressStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        adressStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        adressStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        adressStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        adressStackView.addSubview(adressPlaceholder)
        adressStackView.addSubview(adressTextField)
    }
}
