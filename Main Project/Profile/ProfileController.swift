//
//  ProfileViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 05.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {
    
    //MARK: - Properties
    var barDelegate: ProfileControllerDelegate?
    var ref = Database.database().reference()
    let user = Auth.auth().currentUser
    
    var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    var registrationView: RegistrationView = {
        let registrationView = RegistrationView(frame: .zero)
        registrationView.translatesAutoresizingMaskIntoConstraints = false
        return registrationView
    }()
    
    var userInfo: UserInfoView = {
        let user = UserInfoView(frame: .zero)
        user.translatesAutoresizingMaskIntoConstraints = false
        return user
    }()
    
    
    //MARK: - ViewDidLoad Method
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        view.addSubview(stack)
        stack.addArrangedSubview(registrationView)
        setUpStack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureNaivationBar()

        stack.removeArrangedSubview(userInfo)
        userInfo.removeFromSuperview()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.registrationView.loginButton.setTitle("Войти", for: .normal)
                self.registrationView.logOutButton.removeFromSuperview()
                self.registrationView.loginButton.addTarget(self, action: #selector(self.openNewVC), for: .touchUpInside)
                self.registrationView.adress.isEnabled = false
                self.registrationView.name.isEnabled = false
                self.registrationView.name.text = ""
                self.registrationView.adress.text = ""
            } else {
                self.registrationView.loginButton.setTitle("Сохранить", for: .normal)
                self.registrationView.name.isEnabled = true
                self.registrationView.adress.isEnabled = true
                self.registrationView.stack.addArrangedSubview(self.registrationView.logOutButton)
                self.registrationView.loginButton.removeTarget(self, action: #selector(self.openNewVC), for: .touchUpInside)
                self.registrationView.loginButton.addTarget(self, action: #selector(self.handleLoginButton), for: .touchUpInside)
                self.registrationView.logOutButton.addTarget(self, action: #selector(self.logOut), for: .touchUpInside)
                self.parsingInformation()
            }
        }
    }
    
    //MARK: - Setup UI
    
    func setUpStack() {
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
    }
    
    
    func configureNaivationBar() {
        navigationController?.navigationBar.barStyle = .black
        
        let leftButton = UIButton(type: .system)
        leftButton.setImage(UIImage(named: "lines"), for: .normal)
        leftButton.addTarget(self, action: #selector(openHamburgerAction), for: .touchUpInside)
        leftButton.tintColor = .white
        
        let rightButton = UIButton(type: .system)
        rightButton.setImage(UIImage(named: "Cart"), for: .normal)
        rightButton.addTarget(self, action: #selector(openShoppingCardAction), for: .touchUpInside)
        rightButton.tintColor = .white
        
        let titleView = UILabel(frame: .zero)
        titleView.text = "Профиль"
        titleView.font = .boldSystemFont(ofSize: 20)
        titleView.textColor = .white
        titleView.textAlignment = .center
        
        navigationController?.navigationBar.barTintColor = .orange
        
        let navBar = navigationController?.navigationBar as? MainNavigationBar
        navBar?.setLeftButton(leftButton)
        navBar?.setRightButton(rightButton)
        navBar?.setCenterView(titleView)
        navBar?.leftButton.isHidden = false
    }
    
    //MARK: - Handlers
    
    @objc func openHamburgerAction() {
        barDelegate?.hamburgerButtonDidTap()
        
        print("hello")
    }
    
    @objc func openShoppingCardAction() {
        if let rootVC = UIApplication.shared.windows.first?.rootViewController as? ViewController {
            rootVC.hamburgerMenuController.delegate?.handleMenuToggle(forMenuOption: MenuOptionModel.ShoppingCard)
        }

        barDelegate?.shoppingCartButtonDidTap()
    }
    
    @objc func openNewVC() {
        let vc = TelephoneNumberViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleLoginButton() {
        stack.insertArrangedSubview(userInfo, at: 0)
        guard let id = UserDefaults.standard.string(forKey: "id") else { return }
        self.ref.child("users/\(id)/name").setValue(registrationView.name.text ?? "")
        self.ref.child("users/\(id)/address").setValue(registrationView.adress.text ?? "")
        NetworkManager().getUserInfo(id: id) { (userInfo, _) in
            DispatchQueue.main.async {
                self.userInfo.raitingLabel.text = "Ваш рейтинг: \(userInfo?.place ?? 0)"
                self.userInfo.monthLabel.text = "За месяц: " + (userInfo?.pointM ?? "0")
                self.userInfo.allTimeLabel.text = "За все время: " + (userInfo?.point ?? "0")
            }
        }
        let ac = UIAlertController(title: "Сохранено!", message: "Ваше имя и адрес были обновлены.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parsingInformation() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let currentUser = user {
                let userRef = self.ref.child("users").child(currentUser.uid)
                userRef.observe(.value) { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let name = value?["name"] as? String ?? "Name"
                    let adress = value?["address"] as? String ?? "Adress"
                    self.registrationView.name.text = name
                    self.registrationView.adress.text = adress
                }
            }
        }
        stack.insertArrangedSubview(userInfo, at: 0)
        guard let id = UserDefaults.standard.string(forKey: "id") else { return }
        NetworkManager().getUserInfo(id: id) { (userInfo, _) in
            DispatchQueue.main.async {
                self.userInfo.raitingLabel.text = "Ваш рейтинг: \(userInfo?.place ?? 0)"
                self.userInfo.monthLabel.text = "За месяц: " + (userInfo?.pointM ?? "0")
                self.userInfo.allTimeLabel.text = "За все время: " + (userInfo?.point ?? "0")
            }
        }
    }
    
    @objc func logOut() {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "teamID")
        UserDefaults.standard.removeObject(forKey: "phone")
        stack.removeArrangedSubview(userInfo)
        userInfo.removeFromSuperview()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
