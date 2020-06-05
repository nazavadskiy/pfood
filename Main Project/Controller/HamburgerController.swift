//
//  MenuViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 04.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

private let reuseIndetifier = "MyCell"

class HamburgerController: UIViewController {
    
    //MARK: - Properties
    var tableView: UITableView!
    var delegate: HamburgerMenuDelegate?
    var userViewInMenu: UserProfileInMenu!
    var ref = Database.database().reference()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        configureUserView()
        configureTableView()
        contactsLabel()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.userViewInMenu.nameLabel.text = "Зарегистрируйтесь"
                self.userViewInMenu.phoneNumberLabel.text = ""
            } else {
                if let currentUser = user {
                    let userRef = self.ref.child("users").child(currentUser.uid)
                    userRef.observe(.value) { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                        let name = value?["name"] as? String ?? "Name"
                        let adress = value?["address"] as? String ?? "Adress"
                        self.userViewInMenu.nameLabel.text = name
                        self.userViewInMenu.phoneNumberLabel.text = adress
                    }
                }
            }
        }
    }
    
    //MARK: - Handlers
    
    func configureUserView() {
        userViewInMenu = UserProfileInMenu()
        view.addSubview(userViewInMenu)
        userViewInMenu.translatesAutoresizingMaskIntoConstraints = false
        userViewInMenu.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        userViewInMenu.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        userViewInMenu.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4).isActive = true
        userViewInMenu.backgroundColor = .orange
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIndetifier)
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: userViewInMenu.bottomAnchor).isActive = true
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        } else {
            tableView.backgroundColor = .white
        }
    }
    
    func contactsLabel() {
        let label = UILabel(frame: .zero)
        label.text = "Наши контакты:\n8-(999)-123-45-67"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        label.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.backgroundColor = .white
            label.textColor = .black
        }
    }
    
    var userId: String? {
        willSet {
            if newValue != self.userId {
                self.ref.child("courier_ids").observe(.value) { (snapshot) in
                    for nextId in snapshot.value as? NSArray ?? [] {
                        guard let nextId = nextId as? String else { continue }
                        if nextId == self.userId {
                            self.menuCount = 5
                            self.tableView.reloadData()
                            break
                        }
                    }
                }
                
                self.ref.child("chef_ids").observe(.value) { (snapshot) in
                    for nextId in snapshot.value as? NSArray ?? [] {
                        guard let nextId = nextId as? String else { continue }
                        if nextId == self.userId {
                            self.menuCount = 5
                            self.tableView.reloadData()
                            break
                        }
                    }
                }
                self.menuCount = 4
                self.tableView.reloadData()
            }
        }
    }
    var menuCount = 4
}

extension HamburgerController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
        guard let id = UserDefaults.standard.string(forKey: "id") else { return 4 }
        self.userId = id
        return menuCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndetifier, for: indexPath) as! MenuOptionCell
        let modelOption = MenuOptionModel(rawValue: indexPath.row)
        cell.menuOptionLabel.text = modelOption?.description
        cell.iconImageView.image = UIImage(named: modelOption?.image ?? "cart")
        if #available(iOS 13.0, *) {
            cell.backgroundColor = .systemBackground
        } else {
            cell.backgroundColor = .white
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOptionModel(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    
}
