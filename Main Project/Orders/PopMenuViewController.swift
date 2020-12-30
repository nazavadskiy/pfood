//
//  PopMenuViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 25.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

class PopMenuViewController: UIViewController {
    
    var delegate: ChangeOrderViewController?
    
    var tableView: UITableView!
    var menuArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = Database.database().reference().child("categories")
        ref.observe(.value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let name = child.key as String
                let categories = ref.child(name)
                categories.observe(.value) { (datasnap) in
                    for snap in datasnap.children.allObjects as! [DataSnapshot] {
                        let newName = (snap.value as? NSDictionary)?["name"] as? String ?? ""
                        print(newName)
                        self.menuArray.append(newName)
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        } else {
            tableView.backgroundColor = .white
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView!)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

extension PopMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        delegate?.addItem(name: cell?.textLabel?.text ?? "", count: 1)
        self.dismiss(animated: true, completion: nil)
    }
    
}
