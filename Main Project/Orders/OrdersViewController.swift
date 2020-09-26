//
//  OrdersViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 15.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

class OrdersViewController: UIViewController {
    weak var barDelegate: RaitingsControllerDelegate?
    private var refreshControl = UIRefreshControl()
    let ref = Database.database().reference()
    
    @objc func refreshData(_ sender: Any) {
        orders.removeAll()
        getData()
    }
    
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
        
        let navBar = navigationController?.navigationBar as? MainNavigationBar
        navBar?.leftButton.isHidden = false

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        configureNaivationBar()
        configureTableView()
        getData()
    }
    
    //MARK: - UI
    fileprivate func configureTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        getData()
        
    }
    
    fileprivate func configureNaivationBar() {
        navigationController?.navigationBar.barTintColor = .orange
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor  = .white
        
        let leftButton = UIButton(type: .system)
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        leftButton.setImage(UIImage(named: "lines"), for: .normal)
        leftButton.addTarget(self, action: #selector(openHamburgerAction), for: .touchUpInside)
        leftButton.tintColor = .white

        let rightButton = UIButton(type: .system)
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
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

    fileprivate func configureStatusLablel(_ strInfo: String) -> UIColor? {
        switch strInfo {
        case "Получен":
            return .gray
        case "Отказан":
            return .red
        case "Выполнен":
            return .green
        case "В работе":
            return .orange
        default:
            return nil
        }
    }
    
    //MARK: - network protocol
    fileprivate func getData() {
        let orders = ref.child("orders")
        orders.observe(.value) { (snapshot) in
            for pOrder in snapshot.children.allObjects as! [DataSnapshot] {
                let address = (pOrder.value as? NSDictionary)?["address"] as? String ?? ""
                let name = (pOrder.value as? NSDictionary)?["name"] as? String ?? ""
                let completeTime = (pOrder.value as? NSDictionary)?["complete_time"] as? String ?? ""
                let orderP = (pOrder.value as? NSDictionary)?["order_p"] as? String ?? ""
                let paymentType = (pOrder.value as? NSDictionary)?["payment_type"] as? String ?? ""
                let phone = (pOrder.value as? NSDictionary)?["phone"] as? String ?? ""
                let price = (pOrder.value as? NSDictionary)?["price"] as? String ?? ""
                let status = (pOrder.value as? NSDictionary)?["status"] as? String ?? ""
                let time = (pOrder.value as? NSDictionary)?["time"] as? String ?? ""
                let id = pOrder.key
                
                let orderPeace = OrderRequest(name: name, address: address, phone: phone, price: price, time: time, paymentType: paymentType, orderP: orderP, completeTime: completeTime, status: status, id: id)
                self.orders.insert(orderPeace, at: 0)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.refreshControl?.endRefreshing()
                }
            }
        }
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
        infoOrderView.statusLabel.textColor = configureStatusLablel(orders[indexPath.row].status)
        infoOrderView.statusLabel.text = orders[indexPath.row].status
        infoOrderView.moreButton.isHidden = true
        
        return infoOrderView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailOrderViewController()
        vc.id = orders[indexPath.row].id
        vc.order = orders[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)

    }
    
}
