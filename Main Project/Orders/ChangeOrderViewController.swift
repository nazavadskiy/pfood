//
//  ChangeOrderViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 25.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

class ChangeOrderViewController: UIViewController {
    
    //MARK: - Properties
    var order: OrderRequest?
    
    var scrollView: UIScrollView!
    
    let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    var orderView: UIStackView = {
        let orderStack = UIStackView(frame: .zero)
        orderStack.axis = .vertical
        orderStack.spacing = 10
        orderStack.distribution = .fillEqually
        return orderStack
    }()
    
    let changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить позицию", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(changeOrder), for: .touchUpInside)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить изменния", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return button
    }()

    
    private func setUpStack() {
        mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 46).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 9/10).isActive = true
        mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor).isActive = true
    }
    
    fileprivate func setUpScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        orderView.arrangedSubviews.forEach {
            orderView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        for one in order?.orderP.split(separator: "|") ?? [] {
            let parts = one.split(separator: " ")
            var name = ""
            for (count, part) in parts.enumerated() {
                if count == parts.count - 1 { break }
                name += name == "" ? part : " " + part
            }
            let count = Int(String(parts.last?.dropLast(3) ?? "")) ?? 0
            self.addItem(name: name, count: count)
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        scrollView = UIScrollView(frame: .zero)
        scrollView.contentInsetAdjustmentBehavior = .automatic
        view.addSubview(scrollView)
        setUpScrollView()
        scrollView.addSubview(mainStackView)
        setUpStack()
        mainStackView.addArrangedSubview(orderView)
        mainStackView.addArrangedSubview(changeButton)
        mainStackView.addArrangedSubview(saveButton)
        scrollView.contentSize = mainStackView.bounds.size
        
//        navigationItem.setHidesBackButton(true, animated: false)
        let navBar = navigationController?.navigationBar as? MainNavigationBar
        navBar?.leftButton.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        var orderText = ""
        var i = 0
        for view in self.orderView.arrangedSubviews {
            i += 1
            guard let orderItem = view as? OrderChangeItem else { return }
            guard let item = orderItem.item else { return }
            orderText += "\(item.name) \(String(orderItem.count))шт."
            if i < self.orderView.arrangedSubviews.count { orderText += " | "}
        }
        self.order?.orderP = orderText
    }
    
    @objc func changeOrder() {
        let pop = PopMenuViewController()
        pop.delegate = self
        present(pop, animated: true, completion: nil)
    }
    
    func addItem(name nameItem: String, count: Int) {
        let ref = Database.database().reference().child("categories")
        ref.observe(.value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let name = child.key as String
                let categories = ref.child(name)
                categories.observe(.value) { (datasnap) in
                    for snap in datasnap.children.allObjects as! [DataSnapshot] {
                        let value = (snap.value as? NSDictionary)
                        let newName = (snap.value as? NSDictionary)?["name"] as? String ?? ""
                        if nameItem == newName {
                            let description = value?["description"] as? String ?? ""
                            let imageURL = value?["imageUrl"] as? String ?? ""
                            let name = value?["name"] as? String ?? ""
                            let price = value?["price"] as? Int ?? 0
                            let products = value?["products"] as? String ?? ""
                            let sale = value?["sale"] as? Bool ?? false
                            let newNextMenuModel = NextMenuModel(description: description, imageURL: imageURL, name: name, price: price, products: products, sale: sale)
                            self.order?.orderP += " | \(name) 0шт."
                            self.addItem(model: newNextMenuModel, count: count)
                        }
                    }
                }
            }
        }
    }
    
    
    func addItem(model: NextMenuModel, count: Int) {
        DispatchQueue.main.async {
            let a = OrderChangeItem()
            a.count = count
            a.item = model
            self.orderView.addArrangedSubview(a)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func saveAction() {
        guard let order = order else { return }
        NetworkManager().setDetailOrder(id: order.id,
                                        orderP: order.orderP,
                                        comment: "",
                                        completion: { (suc, _) in
            if (suc?.done ?? 0) == 1 {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                let alert = UIAlertController(title: "Заказы", message: "Запрос не изменился", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }

    
}
