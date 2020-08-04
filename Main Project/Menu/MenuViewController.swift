//
//  HomeViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 04.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

private let reusableIdentifier = "myCell"

class MenuViewController: UIViewController {
    
    var ref: DatabaseReference = Database.database().reference()
    var modelArray: [MenuModel] = []
    
    //MARK: - Properties
    weak  var barDelegate: MenuControllerDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        layout.itemSize = CGSize(width: (width - 60) / 2, height: width / 2)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 50
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: reusableIdentifier)
        
        return collectionView
    }()
    
    //MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        let categories = ref.child("categories")
        categories.observe(.value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let name = child.key as String
                var imageURL = ""
                
                let categories = categories.child(name)
                categories.observe(.value) { (snapshot) in
                    let firstInCategory = snapshot.children.first { _ in return true } as! DataSnapshot
                    imageURL = (firstInCategory.value as? NSDictionary)?["imageUrl"] as? String ?? ""
                    let menuModel = MenuModel(name: name, imageURL: imageURL)
                    self.modelArray.append(menuModel)
                    self.collectionView.reloadData()
                }
            }
        }
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        configureNaivationBar()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navBar = navigationController?.navigationBar as? MainNavigationBar
        navBar?.leftButton.isHidden = false
    }
    
    //MARK: - Configure UI
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .white
        }
    }
    
    func configureNaivationBar() {
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
        titleView.text = "Меню"
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
    }
}


//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! MenuCollectionViewCell
        cell.itemButton.setTitle(String(modelArray[indexPath.row].name), for: .normal)
        
        let urlText = modelArray[indexPath.row].imageURL
        let ref = Storage.storage().reference(forURL: String(urlText))
        let megabyte = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megabyte, completion: { data, error in
            guard let imageData = data else { return }
            let image = UIImage(data: imageData)
            cell.itemImageView.image = image
        })
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MenuCollectionViewCell
        let nexMenuVC = NextMenuViewController()
        nexMenuVC.titleText = cell.itemButton.titleLabel?.text
        self.navigationController?.pushViewController(nexMenuVC, animated: true)
    }
}
