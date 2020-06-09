//
//  InfoTeamViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 18.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import Firebase

class InfoTeamViewController: UIViewController {
    
    var team: TeamModel?
    
    let titleName: UILabel = {
        let label = UILabel()
        label.text = "Место в рейтинге"
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.backgroundColor = .white
            label.textColor = .black
        }
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    let raitingTopLabel: UILabel = {
        let label = UILabel()
        label.text = "Место в рейтинге"
        label.textColor = .lightGray
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
        } else {
            label.backgroundColor = .white
        }
        return label
    }()
    
    let raitingPosition: UILabel = {
        let label = UILabel()
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.backgroundColor = .white
            label.textColor = .black
        }
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Баллов у команды"
        label.textColor = .lightGray
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
        } else {
            label.backgroundColor = .white
        }
        return label
    }()
    
    let raiting: UILabel = {
        let label = UILabel()
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.backgroundColor = .white
            label.textColor = .black
        }
        return label
    }()
    
    let referalCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Пригласительный код"
        label.textColor = .lightGray
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
        } else {
            label.backgroundColor = .white
        }
        return label
    }()
    
    let inviteLabel: UILabel = {
        let label = UILabel()
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
            label.textColor = UIColor(named: "mainColor")
        } else {
            label.backgroundColor = .white
            label.textColor = .black
        }
        return label
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 20
        return stack
    }()
    
    var userStack: UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 5
        return stack
    }
    
    var userNameLabel: UILabel {
        let label = UILabel()
        label.textColor = .lightGray
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
        } else {
            label.backgroundColor = .white
        }
        return label
    }
    
    var userPointLabel: UILabel {
        let label = UILabel()
        label.textColor = .lightGray
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
        } else {
            label.backgroundColor = .white
        }
        return label
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        setUpStack()
        setUpUI()
//        navigationItem.setHidesBackButton(true, animated: false)
        let navBar = navigationController?.navigationBar as? MainNavigationBar
        navBar?.leftButton.isHidden = true
        navigationController?.navigationBar.tintColor  = .white
    }
    
    func setUpStack() {
        view.addSubview(stack)
        stack.addArrangedSubview(titleName)
        stack.addArrangedSubview(raitingTopLabel)
        stack.addArrangedSubview(raitingPosition)
        stack.addArrangedSubview(scoreLabel)
        stack.addArrangedSubview(raiting)
        stack.addArrangedSubview(referalCodeLabel)
        stack.addArrangedSubview(inviteLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        stack.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16).isActive = true
    }
    
    func setUpUI() {
        NetworkManager().getUserInTeam(idTeam: team?.teamId ?? "0") { (teamUsers, error) in
            let teamUsers = teamUsers?.sorted {
                Int($0.points) ?? 0 > Int($1.points) ?? 0
            }
            for user in teamUsers ?? [] {
                print(user)
                let ref = Database.database().reference(withPath: "users")
                let userRef = ref.child(user.id)
                var username = ""
                userRef.observe(.value) { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    username = value?["name"] as? String ?? ""
                    DispatchQueue.main.async {
                        let stack = self.userStack
                        let name = self.userNameLabel
                        name.text = username
                        let point = self.userPointLabel
                        point.text = user.points
                        stack.addArrangedSubview(name)
                        stack.addArrangedSubview(point)
                        self.stack.addArrangedSubview(stack)
                        self.view.layoutIfNeeded()
                    }
                }
            }
        }
        
        
        titleName.text = team?.teamName
        raitingPosition.text = String(team?.teamPlace ?? 0)
        raiting.text = String(team?.teamRaiting ?? 0)
        inviteLabel.text = team?.invite
        print(titleName.text ?? "")
        print(team?.teamName ?? "")
    }
}
