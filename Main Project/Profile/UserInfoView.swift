//
//  UserInfoView.swift
//  Main Project
//
//  Created by Тимур Бакланов on 15.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class UserInfoView: UIView {
     
        //MARK: - Creating UI elements
        fileprivate let stack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.spacing = 15
            return stack
        }()
        
    let firstLinePlaceholder: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "Ваше место в рейтинге"
        return label
    }()
    
    let allTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "За все время: "
        return label
    }()
    
    let monthLabel: UILabel = {
           let label = UILabel()
           label.text = "За месяц: "
           return label
       }()
    
     let raitingLabel: UILabel = {
              let label = UILabel()
              label.text = "Ваш рейтинг: "
              return label
          }()
        //MARK: - Init
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.addSubview(stack)
            stack.addArrangedSubview(firstLinePlaceholder)
            stack.addArrangedSubview(allTimeLabel)
            stack.addArrangedSubview(monthLabel)
            stack.addArrangedSubview(raitingLabel)
            setStackConstraints()
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
