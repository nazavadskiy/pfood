//
//  OTPViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 18.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

class OTPViewController: UIViewController {
    
    //MARK: - Properties
    var ref = Database.database().reference().child("users")
    
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Пожалуйста, введите код подтверждения ниже: "
        if #available(iOS 13.0, *) {
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.textColor = .black
        }
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let otpTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите код подтверждения"
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .phonePad
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("ВВЕСТИ КОД", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 12
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        let navBar = navigationController?.navigationBar as? MainNavigationBar
        navBar?.leftButton.isHidden = true
        navigationController?.navigationBar.tintColor  = .white
        hideKeyboardWhenTappedAround()
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(otpTextField)
        mainStack.addArrangedSubview(registerButton)
        otpTextField.setBottomBorder()
        if #available(iOS 13.0, *) {
            otpTextField.textColor = UIColor(named: "mainColor")
            otpTextField.backgroundColor = .systemBackground
        } else {
            otpTextField.textColor = .black
            otpTextField.backgroundColor = .white
        }
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        setUpView()
    }
    
    func setUpView() {
        mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        mainStack.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 1/5).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    @objc func register() {
        guard let otpText = otpTextField.text else { return }
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {return}
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otpText)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error == nil {
                let currentUser = Auth.auth().currentUser?.uid
                let defaults = UserDefaults.standard
                defaults.set(currentUser, forKey: "id")
                guard let uid = currentUser else { return }
                let uidRef = Database.database().reference().child("users").child(uid)
                uidRef.observe(.value) { (snapshot) in
                    print(snapshot)
                    if snapshot.exists() == false {
                        self.navigationController?.pushViewController(UserInfoViewController(), animated: true)
                    } else {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
                
                
            } else {
                self.mainStack.insertArrangedSubview(self.errorLabel, at: 0)
                self.errorLabel.text = error?.localizedDescription
            }
        }
    }
    
}
