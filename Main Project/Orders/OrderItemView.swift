//
//  OrderItemView.swift
//  Main Project
//
//  Created by Тимур Бакланов on 24.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class OrderItemView: UIView {
    var delegate: DetailOrderViewController?
    
    
    // MARK: - UI
    var item: NextMenuModel? {
        didSet {
            guard let newValue = self.item else { return }
            titleLabel.text = newValue.name
            numberLabel.text = String(ShoppingCart.shared.items[newValue] ?? 0) + " шт."
        }
    }
    let titleLabel: UILabel = {
        let sumLabel = UILabel(frame: .zero)
        sumLabel.textAlignment = .left
        return sumLabel
    }()
    
    let numberLabel: UILabel = {
        let sumLabel = UILabel(frame: .zero)
        sumLabel.textAlignment = .left
        return sumLabel
    }()
    
    var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 5
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainStack)
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(numberLabel)
    }
    
    func configureStackView() {
        mainStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
