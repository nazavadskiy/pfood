//
//  RaitingCell.swift
//  Main Project
//
//  Created by Тимур Бакланов on 07.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class RaitingCell: UITableViewCell {
    
    let numberLabel: UILabel = {
       let label = UILabel()
        label.text = "1"
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.backgroundColor = .white
            label.textColor = .black
        }
        label.font = .systemFont(ofSize: 24)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor(named: "mainColor")
        } else {
            view.backgroundColor = .black
        }
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        return view
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "test"
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.backgroundColor = .white
            label.textColor = .black
        }
        label.font = .systemFont(ofSize: 24)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.backgroundColor = .white
            label.textColor = .black
        }
        label.font = .systemFont(ofSize: 24)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    let labelStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 5
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(labelStack)
        labelStack.addArrangedSubview(numberLabel)
        labelStack.addArrangedSubview(separator)
        labelStack.addArrangedSubview(nicknameLabel)
        labelStack.addArrangedSubview(scoreLabel)
        setUpLabelStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Handlers
    
    func setUpLabelStack() {
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        labelStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
