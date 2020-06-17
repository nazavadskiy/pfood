//
//  OrdersViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 15.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {
    weak var barDelegate: RaitingsControllerDelegate?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(InfoOrderView.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        } else {
            tableView.backgroundColor = .white
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var orders: [OrderRequest] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNaivationBar()
        
        NetworkManager().getInfoOrder { (orders, error) in
            self.orders = orders ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func configureNaivationBar() {
        navigationController?.navigationBar.barTintColor = .orange
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
        titleView.text = "Заказ"
        titleView.font = .boldSystemFont(ofSize: 20)
        titleView.textColor = .white
        titleView.textAlignment = .center
        
        let navBar = navigationController?.navigationBar as? MainNavigationBar
        navBar?.setLeftButton(leftButton)
        navBar?.setRightButton(rightButton)
        navBar?.setCenterView(titleView)
        
        navBar?.sumLabel.text = String(ShoppingCart.shared.getSum())
    }
    
    //MARK: - Handlers
        
    @objc func openHamburgerAction() {
        barDelegate?.hamburgerButtonDidTap()
    }
    
    @objc func openShoppingCardAction() {
        if let rootVC = UIApplication.shared.windows.first?.rootViewController as? ViewController {
            rootVC.hamburgerMenuController.delegate?.handleMenuToggle(forMenuOption: MenuOptionModel.ShoppingCard)
        }
        barDelegate?.shoppingCartButtonDidTap()
    }
}


extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let infoOrderView = cell as? InfoOrderView else { return InfoOrderView() }
        infoOrderView.userNameLabel.text = orders[indexPath.row].name
        infoOrderView.adressLabel.text = orders[indexPath.row].address
        infoOrderView.dataLabel.text = orders[indexPath.row].time
        infoOrderView.phoneNumberLabel.text = orders[indexPath.row].phone
        return infoOrderView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailOrderViewController()
        vc.order = orders[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)

    }
    
}
