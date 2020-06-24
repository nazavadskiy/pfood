//
//  DetailOrderViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 15.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

class DetailOrderViewController: UIViewController {
    
    var order: OrderRequest?
    
    //MARK: - Properties
    var scrollView: UIScrollView!
    var ref = Database.database().reference()
    
    weak var barDelegate: ShoppingCartCoordinator?
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.text = "Name"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    let phone: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.text = "+7xxxxxxxxxx"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    let orderTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.text = "Время заказа: хх-хх-хх"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.text = "Цена заказа: хххх₽"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let orderPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Заказ: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let adress: UILabel = {
        let label = UILabel()
        label.text = "Адрес: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let userAdress: UILabel = {
        let label = UILabel()
        label.text = "Адрес1"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let paymentType: UILabel = {
        let label = UILabel()
        label.text = "Тип оплаты: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let userPayment: UILabel = {
        let label = UILabel()
        label.text = "Оплата1"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let commentaryPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Комментарий к заказу: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let commentaryTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 18)
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return textField
    }()
    
    let buttonStack: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    lazy var saveChangesButton: UIButton = {
        let button = UIButton()
        button.setTitle("СОХР. ИЗМЕНЕНИЯ", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    let changeOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("ИЗМЕНИТЬ ЗАКАЗ", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(changeOrder), for: .touchUpInside)
        return button
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setTitle("ЗАКАЗ ВЫПОЛНЕН", for: .normal)
        button.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setTitle("УДАЛИТЬ ЗАКАЗ", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    var orderView: UIStackView = {
        let orderStack = UIStackView(frame: .zero)
        orderStack.axis = .vertical
        orderStack.spacing = 10
        orderStack.distribution = .fill
        return orderStack
    }()
    
    
    //MARK: - Configure UI
    
    fileprivate func configureScrollView() {
        scrollView = UIScrollView(frame: .zero)
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.addSubview(stack)
        scrollView.contentSize = stack.bounds.size
    }
    
    fileprivate func configureStackView() {
        stack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        stack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 9/10).isActive = true
        stack.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor).isActive = true
    }
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        orderView.arrangedSubviews.forEach {
            orderView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        for one in order?.orderP.split(separator: "|") ?? [] {
            let parts = one.split(separator: " ")
            let count = Int(String(parts.last?.dropLast(3) ?? "")) ?? 0
            if count != 0 {
                let a = UILabel(frame: .zero)
                a.text = String(one)
                orderView.addArrangedSubview(a)

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
        configureScrollView()
        configureStackView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

        
        name.text = order?.name
        phone.text = order?.phone
        orderTime.text = order?.time
        price.text = order?.price
        userAdress.text = order?.address
        userPayment.text = order?.paymentType
        commentaryTextField.text = order?.comment
        
        stack.addArrangedSubview(name)
        stack.addArrangedSubview(phone)
        stack.addArrangedSubview(orderTime)
        stack.addArrangedSubview(price)
        stack.addArrangedSubview(orderPlaceholder)
        stack.addArrangedSubview(orderView)
        stack.addArrangedSubview(adress)
        stack.addArrangedSubview(userAdress)
        stack.addArrangedSubview(paymentType)
        stack.addArrangedSubview(userPayment)
        stack.addArrangedSubview(commentaryPlaceholder)
        stack.addArrangedSubview(commentaryTextField)
        buttonStack.addArrangedSubview(saveChangesButton)
        buttonStack.addArrangedSubview(changeOrderButton)
        stack.addArrangedSubview(doneButton)
        
        self.addAdminKeys()
        
//        navigationItem.setHidesBackButton(true, animated: false)
        let navBar = navigationController?.navigationBar as? MainNavigationBar
        navBar?.leftButton.isHidden = true
    }

    func addAdminKeys() {
        guard let id = UserDefaults.standard.string(forKey: "id") else { return }
//        id = "rtbTsf1NGPgM9Um4mrPsU9kO3PL2"
        self.ref.child("chef_ids").observe(.value) { [weak self] (snapshot) in
            for nextId in snapshot.value as? NSArray ?? [] {
                guard let nextId = nextId as? String, let self = self else { continue }
                if nextId == id {
                    self.stack.addArrangedSubview(self.buttonStack)
                    self.stack.addArrangedSubview(self.deleteButton)
                    break
                }
            }
        }
    }
    
    
    //MARK: - Handlers
    
    @objc func changeOrder() {
        let vc = ChangeOrderViewController()
        vc.order = self.order
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func doneAction() {
        guard let orderId = order?.id else { return }
        NetworkManager().setInfoOrder(id: orderId) { (suc, _) in
            if (suc?.done ?? 0) == 1 {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                let alert = UIAlertController(title: "Заказы", message: "Запрос не закрылся", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    @objc func saveAction() {
        guard let order = order else { return }
        NetworkManager().setDetailOrder(id: order.id,
                                        orderP: order.orderP,
                                        comment:commentaryTextField.text ?? "" ,
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
    
    
    var isKeyboardShown = false

    @objc func keyboardWillShow(notification:NSNotification){
        if isKeyboardShown { return }
        isKeyboardShown = true

        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        UIView.animate(withDuration: 0.5) {
            self.scrollView.contentInset = contentInset
            self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
            self.scrollView.contentOffset.y += keyboardFrame.size.height
        }
    }

    @objc func keyboardWillHide(notification:NSNotification){
        isKeyboardShown = false
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }

    
    
}
