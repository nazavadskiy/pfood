//
//  NextMenuCell.swift
//  Main Project
//
//  Created by Тимур Бакланов on 08.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class NextMenuCell: UICollectionViewCell {
    //MARK: - Properties
    
    var count = 0 {
        willSet {
            numberItem.text = "\(newValue)"
            if newValue == 0 {
                stackUpButtons.isHidden = true
            } else {
                stackUpButtons.isHidden = false
            }
        }
    }
    
    var item: NextMenuModel? {
        willSet {
            guard let newValue = newValue else { return }
            itemLabel.text = newValue.name
            itemButton.setTitle(String(newValue.price) + " ₽", for: .normal)
            itemImageView.load(model: newValue)
            count = ShoppingCart.shared.items[newValue] ?? 0
        }
    }
    
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
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    lazy var itemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Test", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(handleAddItem), for: .touchUpInside)
        return button
    }()
    
    let stackUpButtons: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    let bottomView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.backgroundColor = .orange
        return view
    }()
    
    lazy var numberItem: UILabel = {
        let label = UILabel()
        label.text = "\(self.count)"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    
    fileprivate func buttonConstraints() {
        itemButton.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        itemButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        itemButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        itemButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
    }
    
    fileprivate func stackConstraints() {
        stackUpButtons.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        stackUpButtons.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        stackUpButtons.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        stackUpButtons.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(itemStack)
        setUpStack()
        itemStack.addArrangedSubview(itemImageView)
        itemStack.addArrangedSubview(itemLabel)
        itemStack.addArrangedSubview(bottomView)
        
        bottomView.addSubview(itemButton)
        buttonConstraints()
        bottomView.addSubview(stackUpButtons)
        stackUpButtons.addArrangedSubview(plusButton)
        stackUpButtons.addArrangedSubview(numberItem)
        stackUpButtons.addArrangedSubview(minusButton)
        stackConstraints()
        stackUpButtons.isHidden = true
        
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        backgroundColor = .clear
        layer.cornerRadius = 12
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor.black.cgColor
        
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Handlers
    func setUpStack() {
        itemStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        itemStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        itemStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        itemStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    @objc func handleAddItem() {
        guard let item = item else { return }
        ShoppingCart.shared.increaseItemCount(item)
        count = 1
    }
    
    @objc func minusButtonTapped() {
        guard let item = item else { return }
        ShoppingCart.shared.decreaseItemCount(item)
        if count > 0 {
            count -= 1
        }
    }
    
    @objc func plusButtonTapped() {
        guard let item = item else { return }
        ShoppingCart.shared.increaseItemCount(item)
        if count >= 0 {
            count += 1
        }
    }
}


