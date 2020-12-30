//
//  DetailItemViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 16.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import FirebaseStorage

class DetailItemViewController: UIViewController {
    var count = 0 {
        willSet {
            numberItem.text = "\(newValue)"
            if newValue == 0 {
                buttonStack.isHidden = true
            } else {
                buttonStack.isHidden = false
            }
        }
    }
    
    var item: NextMenuModel? {
        willSet {
            guard let newValue = newValue else { return }
            count = ShoppingCart.shared.items[newValue] ?? 0
        }
        didSet {
            setUpUI()
        }
    }
        
    var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 15
        return stack
    }()
    
    var mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
//        image.heightAnchor.constraint(equalTo: ).isActive
        return image
    }()
    
    var nameTitle: UILabel = {
        let label = UILabel()
        label.text = "text"
        label.font = .boldSystemFont(ofSize: 28)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        if #available(iOS 13.0, *) {
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.textColor = .black
        }
        return label
    }()
    
    var price: UILabel = {
        let label = UILabel()
        label.text = "text"
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 18)
        label.textColor = .gray
        label.sizeToFit()
        return label
    }()
    
    var productsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 18)
        label.textColor = .gray
        label.sizeToFit()
        return label
    }()
    
    var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        view.backgroundColor = .orange
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ДОБАВИТЬ В КОРЗИНУ", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.backgroundColor = .orange
        return button
    }()
    
    var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    var numberItem: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.backgroundColor = .white
            label.textColor = .black
        }
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        let scrollView = UIScrollView(frame: .zero)
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.contentInset.bottom += 10
        
        scrollView.addSubview(mainStack)
        mainStack.addArrangedSubview(mainImage)
        mainStack.addArrangedSubview(nameTitle)
        mainStack.addArrangedSubview(price)
        mainStack.addArrangedSubview(bottomView)
        mainStack.addArrangedSubview(descriptionLabel)
        mainStack.addArrangedSubview(productsLabel)
        
        mainImage.heightAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        
        buttonStack.addArrangedSubview(minusButton)
        buttonStack.addArrangedSubview(numberItem)
        buttonStack.addArrangedSubview(plusButton)
        
        bottomView.addSubview(button)
        bottomView.addSubview(buttonStack)
        buttonStack.isHidden = true
        
        mainStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16).isActive = true
        mainStack.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -32).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
        mainStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        button.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        
        buttonStack.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        buttonStack.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        guard let item = item else { return }
        count = ShoppingCart.shared.items[item] ?? 0
        scrollView.contentSize = mainStack.bounds.size
        setUpUI()
    }
    
    func setUpUI() {
        guard let item = item else { return }
        
        let ref = Storage.storage().reference(forURL: item.imageURL)
        let megabyte = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megabyte, completion: { (data, error) in
            guard let imageData = data else { return }
            let image = UIImage(data: imageData)
            self.mainImage.image = image
        })
        
        nameTitle.text = item.name
        price.text = String(item.price) + "₽"
        descriptionLabel.text = item.description
        productsLabel.text = item.products
    }
    
    @objc override func hideKeyboard() {
        print("123")
    }
    
    @objc func buttonTapped() {
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
