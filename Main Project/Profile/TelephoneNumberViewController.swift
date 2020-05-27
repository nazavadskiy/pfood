//
//  TelephoneNumberViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 08.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

class TelephoneNumberViewController: UIViewController {
    
    //MARK: - Properties
    var telView: TelephoneRegView = {
        let telView = TelephoneRegView()
        telView.translatesAutoresizingMaskIntoConstraints = false
        return telView
    }()
    
    var ref = Database.database().reference() // database ref
    
    //MARK: - LifeCycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(telView)
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: false)
        hideKeyboardWhenTappedAround()
        setUpConstraints()
        telView.verifyButton.addTarget(self, action: #selector(verifyUser), for: .touchUpInside)
    }
    
    //MARK: - Methods
    
    fileprivate func setUpConstraints() {
        telView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        telView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        telView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4).isActive = true
        telView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    @objc func verifyUser() {
        var telephoneNumber: String?
        telephoneNumber = "+7" + telView.otherNumberTextField.text!
        
        UserDefaults.standard.set(telephoneNumber, forKey: "phone")
        guard let number = telephoneNumber else {
            return print("there's nothings there")
        }
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (verificationID, error) in
            if error == nil {
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                self.navigationController?.pushViewController(OTPViewController(), animated: true)
            } else {
                self.telView.mainStack.insertArrangedSubview(self.telView.errorLabel, at: 0)
                self.telView.errorLabel.text = error?.localizedDescription
            }
        }
        
    }
}
