//
//  ShoppingCartPlaceholderView.swift
//  Main Project
//
//  Created by Тимур Бакланов on 08.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class ShoppingCartPlaceholderView: UIView {
    
    //MARK: - Properties
    
    let placeholderStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .equalCentering
        return stack
    }()
    
    let namePlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Zakaz"
        if #available(iOS 13.0, *) {
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.textColor = .black
        }
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let sumPlaceholder: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    
    //MARK: - Unit
    init(frame: CGRect, cartModel: ShoppingCartPlaceholderModel) {
        super.init(frame: frame)
        self.addSubview(placeholderStack)
        setUpStack()
        namePlaceholder.text = cartModel.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Handlers
    
    func setUpStack() {
        placeholderStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        placeholderStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        placeholderStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        placeholderStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        placeholderStack.addArrangedSubview(namePlaceholder)
        placeholderStack.addArrangedSubview(sumPlaceholder)
    }
}
