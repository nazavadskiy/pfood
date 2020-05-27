//
//  Util.swift
//  Main Project
//
//  Created by Тимур Бакланов on 16.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation
import UIKit

class Util {
    
    static func styleTextField(_ textField: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 4, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 9/255, alpha: 1).cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension UITextField {
  func setBottomBorder() {
    self.borderStyle = .none
    self.layer.backgroundColor = UIColor.white.cgColor

    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.lightGray.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    self.layer.shadowOpacity = 1.0
    self.layer.shadowRadius = 0.0
  }
}
