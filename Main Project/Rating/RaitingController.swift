//
//  RaitingsViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 07.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "MyRaitingCell"
class RaitingsViewController: UIViewController {
    
    var ref = Database.database().reference()
    var teams: [TeamModel] = []
    
    weak var barDelegate: RaitingsControllerDelegate?
    
    var tableView: UITableView!
    let joinButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Моя команда", for: .normal)
        button.addTarget(self, action: #selector(openMyTeam(_ :)), for: .touchUpInside)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        view.addSubview(joinButton)
        setUpButton()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        count(nil)
        configureNaivationBar()
    }
    
    func positionOf(id: String, _ complition: @escaping (TeamModel)->()){
        count {
            var i = 0
            while (i < self.teams.count) {
                if self.teams[i].teamId == id {
                    complition(self.teams[i])
                    break
                }
                i += 1
            }
        }
    }
    
    func count(_ complition: (()->())?) {
        var teams:[TeamModel] = []
        var count = 0
        NetworkManager().getTopTeam { (response, _) in
            for team in response ?? [] {
                let model = TeamModel(teamName: team.name, teamRating: Int(team.point) ?? 0, invite: team.invite, teamId: team.id)
                count += 1
                model.teamPlace = count
                teams.append(model)
            }
            self.teams = teams
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            complition?()
        }
    }
    
    func setUpTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RaitingCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
            
        } else {
            tableView.backgroundColor = .white
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    
    func setUpButton() {
        joinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        joinButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        joinButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        joinButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc func openMyTeam(_ sender: UIButton) {
        let vc = TeamViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
//        sender.backgroundColor = .red
        let value = sender.layer.opacity
        sender.layer.opacity = 0.3
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.duration = 0.1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.fromValue = sender.layer.opacity
        animation.toValue = sender.layer.opacity = value
        sender.layer.add(animation, forKey: "tapped")
        sender.layer.opacity = value
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
        titleView.text = "Рейтинг"
        titleView.font  = .boldSystemFont(ofSize: 18)
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

extension RaitingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(10, teams.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RaitingCell
        
        guard indexPath.row < teams.count else { return cell }
        cell.nicknameLabel.text = teams[indexPath.row].teamName
        cell.numberLabel.text = String(teams[indexPath.row].teamPlace)
        cell.scoreLabel.text = String(teams[indexPath.row].teamRaiting)
        
        if #available(iOS 13.0, *) {
            cell.layer.backgroundColor = UIColor.systemBackground.cgColor
        } else {
            cell.layer.backgroundColor = UIColor.white.cgColor
        }

        cell.layer.masksToBounds = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = InfoTeamViewController()
        detailVC.team = teams[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .lightGray
        label.text = "Лучшие 10 команд"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.backgroundColor = .white
            label.textColor = .black
        }
        return label
    }
}
