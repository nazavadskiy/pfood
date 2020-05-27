//
//  ShoppingCartViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 08.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

class ShoppingCartViewController: UIViewController {
    
    weak var barDelegate: ShoppingCartCoordinator?
    
    var scrollView: UIScrollView!
    
    let methods = ["Картой", "Наличными"]
    
    let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    let orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("ЗАКАЗАТЬ", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sendOrder), for: .touchUpInside)
        return button
    }()
    
    @objc func sendOrder() {
        guard let _ = UserDefaults.standard.string(forKey: "id") else{
            let alert = UIAlertController(title: "Заказы", message: "Сначала надо авторизироваться!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Вперед!", style: .default, handler: { (_) in
                    if let rootVC = UIApplication.shared.windows.first?.rootViewController as? ViewController {
                    rootVC.hamburgerMenuController.delegate?.openAuthVC()
                }

            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard paymentTextField.text != "",  adressTextField.text != "",
            paymentTextField.text != nil, adressTextField.text != nil else {
                let alert = UIAlertController(title: "Заказы", message: "Заполните, пожалуйста, поля адресса и способа оплаты!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Вперед!", style: .default, handler:nil))
                self.present(alert, animated: true, completion: nil)
                return
        }
        
        ShoppingCart.shared.sendOrder(paymentType: paymentTextField.text ?? "",
                                      adressZakaz: adressTextField.text ?? "") { text in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Заказ", message: text, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    let adressStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    let adressPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Адрес доставки: "
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let adressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Введите адрес доставки"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 18)
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return textField
    }()
    
    let paymentStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    let paymentPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Оплата"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    lazy var paymentTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 18)
        textField.placeholder = " Выберите"
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return textField
    }()
    
    let paymentPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    var seperator: UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
       return view
    }
    
    var orderView: UIStackView = {
        let orderStack = UIStackView(frame: .zero)
        orderStack.axis = .vertical
        orderStack.spacing = 10
        orderStack.distribution = .fill
        return orderStack
    }()
    
    var orderViewTitle = ShoppingCartPlaceholderView(frame: .zero, cartModel: .order)
    var deliveryView = ShoppingCartPlaceholderView(frame: .zero, cartModel: .delivery)
    var sumView = ShoppingCartPlaceholderView(frame: .zero, cartModel: .sum)
    
    fileprivate func extractedFunc() {
        mainStackView.addArrangedSubview(orderViewTitle)
        mainStackView.addArrangedSubview(seperator)
        mainStackView.addArrangedSubview(orderView)
        mainStackView.addArrangedSubview(seperator)
        mainStackView.addArrangedSubview(deliveryView)
        mainStackView.addArrangedSubview(sumView)
        mainStackView.addArrangedSubview(adressStackView)
        mainStackView.addArrangedSubview(paymentStackView)
        mainStackView.addArrangedSubview(orderButton)
    }
    
    private func setUpStack() {
        mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 9/10).isActive = true
        mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor).isActive = true
        extractedFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        scrollView = UIScrollView(frame: .zero)
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.addSubview(mainStackView)
        scrollView.contentSize = mainStackView.bounds.size
        adressStackView.addArrangedSubview(adressPlaceholder)
        adressStackView.addArrangedSubview(adressTextField)
        
        adressTextField.delegate = self
        paymentPicker.dataSource = self
        paymentPicker.delegate = self
        
        paymentTextField.inputView = paymentPicker
        paymentStackView.addArrangedSubview(paymentPlaceholder)
        paymentStackView.addArrangedSubview(paymentTextField)
        setUpStack()
        
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNaivationBar()
        
        orderView.arrangedSubviews.forEach {
            orderView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        for (item, count) in ShoppingCart.shared.items {
            if count == 0 { continue }
            let a = ShoppingCartItem()
            a.delegate = self
            a.item = item
            orderView.addArrangedSubview(a)
        }
        updateSumAndDelivery()
        
        guard let userID = UserDefaults.standard.string(forKey: "id") else { return }
        let ref = Database.database().reference(withPath: "users")
        let userRef = ref.child(userID)
        userRef.observe(.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let address = value?["address"] as? String ?? ""
            DispatchQueue.main.async {
                self.adressTextField.text = address
            }
        }
    }
    
    func updateSumAndDelivery() {
        deliveryView.sumPlaceholder.text = String(ShoppingCart.shared.deliveryPrice())
        sumView.sumPlaceholder.text = String(ShoppingCart.shared.getSum() + ShoppingCart.shared.deliveryPrice())
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
        titleView.text = "Корзина"
        titleView.font = .boldSystemFont(ofSize: 20)
        titleView.textColor = .white
        titleView.textAlignment = .left

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
    
    var isKeyboardShown = false
}

extension ShoppingCartViewController: UITextFieldDelegate {
    @objc func keyboardWillShow(notification:NSNotification){
        if isKeyboardShown { return }
        isKeyboardShown = true

        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        let delta = view.frame.height - mainStackView.frame.height - keyboardFrame.size.height
        guard delta < 0 else { return }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.placeholder == " Выберите" { return false}
        return true
    }
}

extension ShoppingCartViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return methods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return methods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paymentTextField.text = methods[row]
        paymentTextField.resignFirstResponder()
    }
    
}
