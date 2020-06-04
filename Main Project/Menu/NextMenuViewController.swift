//
//  NextMenuViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 08.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

private let reusableIdentifier = "myEatingCell"

class NextMenuViewController: UIViewController {
    
    //MARK: - Firebase
    var ref: DatabaseReference = Database.database().reference()
    var nextMenuModelArray: [NextMenuModel] = []
    
    
    //MARK: - Properties
    var collectionView: UICollectionView!
    var titleText: String?
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let titleText = titleText else { return }
        
        let categories = ref.child("categories").child(titleText)
        categories.observe(.value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let value = child.value as? NSDictionary
                let description = value?["description"] as? String ?? ""
                let imageURL = value?["imageUrl"] as? String ?? ""
                let name = value?["name"] as? String ?? ""
                let price = value?["price"] as? Int ?? 0
                let products = value?["products"] as? String ?? ""
                let sale = value?["sale"] as? Bool ?? false
                let newNextMenuModel = NextMenuModel(description: description, imageURL: imageURL, name: name, price: price, products: products, sale: sale)
                print(newNextMenuModel)
                self.nextMenuModelArray.append(newNextMenuModel)
                print(self.nextMenuModelArray)
                self.collectionView.reloadData()
            }
        }
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
                    
        configureCollectionView()
        let navBar = navigationController?.navigationBar as? MainNavigationBar
        navBar?.leftButton.isHidden = true
    }
    
    
    func configureCollectionView() {        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        layout.itemSize = CGSize(width: (width - 60) / 2 , height: width / 2 + 30)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 50
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NextMenuCell.self, forCellWithReuseIdentifier: reusableIdentifier)
        
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

    
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension NextMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nextMenuModelArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! NextMenuCell
        cell.item = nextMenuModelArray[indexPath.row]
        let urlText = nextMenuModelArray[indexPath.row].imageURL
        guard let url = URL(string: urlText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else { return MenuCollectionViewCell()}
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                guard UIImage(data: data) != nil else { return }
                DispatchQueue.main.async {
                    cell.itemImageView.kf.indicatorType = .activity
                    cell.itemImageView.kf.setImage(with: url)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailItemViewController()
        detailVC.item = nextMenuModelArray[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
    func nextItem(_ item:NextMenuModel?) -> NextMenuModel? {
        guard let item = item else { return nil }
        for (num, i) in nextMenuModelArray.enumerated() {
            if i == item {
                return nextMenuModelArray[(num + 1) % nextMenuModelArray.count - 1]
            }
        }
        return item
    }
    func previousItem(_ item:NextMenuModel?) -> NextMenuModel? {
        guard let item = item else { return nil }
        for (num, i) in nextMenuModelArray.enumerated() {
            if i == item {
                return nextMenuModelArray[num == 0 ? nextMenuModelArray.count - 1 : num-1]
            }
        }
        return item
    }

}

extension UIImageView {
    func load(urlText: String) {
        guard let url = URL(string: urlText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }
        }
    }
    
    func load(model: NextMenuModel) {
        if let image = model.image { self.image = image; return }
        
        let urlText = model.imageURL
        guard let url = URL(string: urlText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    if model.sale {
                        model.image = image.addSale()
                    } else {
                        model.image = image
                    }
                    self?.image = model.image
                    
                    
                }
            }
        }
    }
}

extension UIImage {
    
    func addSale() -> UIImage? {
        guard let saleImage = UIImage(named: "saleicon") else { return nil }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        let hTOw = saleImage.size.width / saleImage.size.width
        saleImage.draw(in: CGRect(x: 3/4 * self.size.width,
                                  y: 0,
                                  width: self.size.width / 4,
                                  height: hTOw * self.size.width / 4))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return resultImage
    }
}
