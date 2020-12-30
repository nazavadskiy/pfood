//
//  OrderChangeItem.swift
//  Main Project
//
//  Created by Gagik on 26.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import FirebaseStorage

class OrderChangeItem: UIView {
    
    var deleg: ChangeOrderViewController?
    
    var count = 0 {
        willSet {
            numberItem.text = "\(newValue)"
            guard let item = item else { return }
            sumLabel.text = "\(newValue * item.price)"
        }
    }
    
    var item: NextMenuModel? {
        didSet {
            guard let newValue = self.item else { return }
//            imageView.load(model: newValue)
            let ref = Storage.storage().reference(forURL: newValue.imageURL)
            let megabyte = Int64(1 * 1024 * 1024)
            ref.getData(maxSize: megabyte, completion: { (data, error) in
                guard let imageData = data else { return }
                let image = UIImage(data: imageData)
                self.imageView.image = image
            })
            titleLabel.text = newValue.name
        }
    }

    // MARK: - UI
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "blank")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    let numberItem: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
        } else {
            label.backgroundColor = .white
        }
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.setImage(UIImage(named: "plus"), for: .normal)
        if #available(iOS 13.0, *) {
            button.imageView?.tintColor = UIColor(named: "mainColor")
            button.backgroundColor = .systemBackground
        } else {
            button.imageView?.tintColor = .black
            button.backgroundColor = .white
        }
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.setImage(UIImage(named: "minus"), for: .normal)
        if #available(iOS 13.0, *) {
            button.imageView?.tintColor = UIColor(named: "mainColor")
            button.backgroundColor = .systemBackground
        } else {
            button.imageView?.tintColor = .black
            button.backgroundColor = .white
        }
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let sumLabel: UILabel = {
        let sumLabel = UILabel(frame: .zero)
        sumLabel.textAlignment = .center
        return sumLabel
    }()
    
    let titleLabel: UILabel = {
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
        
        let veryMainStack = UIStackView()
        veryMainStack.axis = .vertical
        veryMainStack.distribution = .equalCentering
        veryMainStack.alignment = .leading
        veryMainStack.spacing = 5
        
        veryMainStack.addArrangedSubview(titleLabel)
        veryMainStack.addArrangedSubview(mainStack)

        addSubview(veryMainStack)
        
        buttonStack.addArrangedSubview(minusButton)
        buttonStack.addArrangedSubview(numberItem)
        buttonStack.addArrangedSubview(plusButton)
        
        mainStack.addArrangedSubview(imageView)
        mainStack.addArrangedSubview(buttonStack)
        mainStack.addArrangedSubview(sumLabel)
        
        
        let width = UIScreen.main.bounds.width
        veryMainStack.translatesAutoresizingMaskIntoConstraints = false
        veryMainStack.widthAnchor.constraint(equalToConstant: width).isActive = true
        veryMainStack.heightAnchor.constraint(equalToConstant: width/2.7).isActive = true
        veryMainStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        veryMainStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        veryMainStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func minusButtonTapped() {
        if count > 0 {
            count -= 1
        }
    }
    
    @objc func plusButtonTapped() {
        if count >= 0 {
            count += 1
        }
    }
    
}

