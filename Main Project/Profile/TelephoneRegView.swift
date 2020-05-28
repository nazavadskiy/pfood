//
//  TelephoneRegView.swift
//  Main Project
//
//  Created by Тимур Бакланов on 08.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class TelephoneRegView: UIView {
    
    //MARK: - Properties
    let firstNumberArray = ["🇷🇺 +7"]
    
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    let horizStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return stack
    }()
    
    let firstNumberTextField: UITextField = {
        let textField = UITextField()
        textField.text = "🇷🇺 +7"
        if #available(iOS 13.0, *) {
            textField.backgroundColor = .systemBackground
            textField.textColor = UIColor(named: "mainColor")
        } else {
            textField.backgroundColor = .white
            textField.textColor = .black
        }
        return textField
    }()
    
    let otherNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите номер телефона"
        textField.clearButtonMode = .whileEditing
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .phonePad
        if #available(iOS 13.0, *) {
            textField.backgroundColor = .systemBackground
            textField.textColor = UIColor(named: "mainColor")
        } else {
            textField.backgroundColor = .white
            textField.textColor = .black
        }
        return textField
    }()
    
    let otpTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите одноразовый код"
        textField.layer.borderWidth = 2
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .phonePad
        textField.layer.borderColor = UIColor.orange.cgColor
        if #available(iOS 13.0, *) {
            textField.backgroundColor = .systemBackground
            textField.textColor = UIColor(named: "mainColor")
        } else {
            textField.backgroundColor = .white
            textField.textColor = .black
        }
        return textField
    }()
    
    let firstNumberPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let verifyButton: UIButton = {
        let button = UIButton()
        button.setTitle("ПОДТВЕРДИТЬ НОМЕР ТЕЛЕФОНА", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 12
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 14
        button.isEnabled = false
        return button
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "При нажати на \"ПОДТВЕРДИТЬ НОМЕР ТЕЛЕФОНА\" будет отправлено СМС на данный номер"
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 12)
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return label
    }()
    
    var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(mainStack)
        mainStack.addArrangedSubview(horizStack)
        horizStack.addArrangedSubview(firstNumberTextField)
        horizStack.addArrangedSubview(otherNumberTextField)
        mainStack.addArrangedSubview(verifyButton)
        mainStack.addArrangedSubview(descriptionLabel)
        setUpStack()
        
        firstNumberTextField.setBottomBorder()
        otherNumberTextField.setBottomBorder()
        
        
        firstNumberTextField.delegate = self
        otherNumberTextField.delegate = self
        firstNumberTextField.inputView = firstNumberPicker
        firstNumberPicker.delegate = self
        firstNumberPicker.dataSource = self
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: = Handlers
    func setUpStack() {
        mainStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension TelephoneRegView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension TelephoneRegView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return firstNumberArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return firstNumberArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        firstNumberTextField.text = firstNumberArray[row]
        firstNumberTextField.resignFirstResponder()
    }
    
    
}


