//
//  UserInfoViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 18.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

class UserInfoViewController: UIViewController {
    
    //MARK: - Properties
    var ref = Database.database().reference()
    
    fileprivate let stack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.spacing = 10
            return stack
        }()
        
    let namePlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Введите ваше имя:"
        if #available(iOS 13.0, *) {
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.textColor = .black
        }
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let adressPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Введите ваш адрес: "
        if #available(iOS 13.0, *) {
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.textColor = .black
        }
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let nameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Имя"
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    let adressTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Адрес"
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    let loginButton: UIButton = {
           let button = UIButton()
           button.setTitle("Зарегистрироваться", for: .normal)
           button.backgroundColor = .orange
           button.titleLabel?.textColor = .white
           button.titleLabel?.font = .boldSystemFont(ofSize: 18)
           button.layer.cornerRadius = 12
           button.translatesAutoresizingMaskIntoConstraints = false
           button.heightAnchor.constraint(equalToConstant: 60).isActive = true
           return button
       }()
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        
        //settingUpUI
        view.addSubview(stack)
        stack.addArrangedSubview(namePlaceholder)
        stack.addArrangedSubview(nameTextField)
        stack.addArrangedSubview(adressPlaceholder)
        stack.addArrangedSubview(adressTextField)
        stack.addArrangedSubview(loginButton)
        setStackConstraints()
        
        nameTextField.setBottomBorder()
        adressTextField.setBottomBorder()
        loginButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
            nameTextField.backgroundColor = .systemBackground
            adressTextField.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
            nameTextField.backgroundColor = .white
            adressTextField.backgroundColor = .white
        }
    }

    func setStackConstraints() {
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
               stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
               stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
           }
    
    @objc func saveData() {
        let user = Auth.auth().currentUser
        if let currentUser = user {
//            NetworkManager().addUser(id: currentUser.uid) {response,_ in
//                print(response ?? "")
//            }
            let userRef = ref.child("users").child(currentUser.uid)
            let values: [String : Any] = ["address": adressTextField.text ?? "Nil", "name": nameTextField.text ?? "Nil"]
            userRef.setValue(values)
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
