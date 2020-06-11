//
//  TeamViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 07.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController {
    var team: TeamModel?
    
    var delegate: RaitingsViewController?
    
    let titleName: UILabel = {
        let label = UILabel()
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
    
    let joinButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.setTitle("ПРИСОЕДИНИТЬСЯ К КОМАНДЕ", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .orange
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(joinTeam), for: .touchUpInside)
        return button
    }()
    
    lazy private var createTeamButton: UIButton = {
        let button = UIButton()
        button.setTitle("СОЗДАТЬ КОМАНДУ", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.backgroundColor = .orange
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(createTeam), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        setUpStack()
//        navigationItem.setHidesBackButton(true, animated: false)
        let navBar = navigationController?.navigationBar as? MainNavigationBar
        navBar?.leftButton.isHidden = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(copyTap))
        inviteLabel.addGestureRecognizer(gesture)
        inviteLabel.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateController()
    }
    
    func updateController() {
        guard let gvn = UserDefaults.standard.string(forKey: "teamID") else { return }
        if gvn == "brib" {
            let id = UserDefaults.standard.string(forKey: "id")
            guard let userId = id else { return }
            NetworkManager().getTeamUser(id: userId) { (reponse, error) in
                
                self.delegate?.positionOf(id: reponse?.userIdTeam ?? "0") {team in
                    DispatchQueue.main.async {
                        self.titleName.text = reponse?.name
                        self.raiting.text = String(team.teamPlace)
                        self.raitingPosition.text = String(team.teamRaiting)
                        self.inviteLabel.text = team.invite
                        self.joinButton.isHidden = true
                        self.createTeamButton.isHidden = true
                    }
                }
                
            }
        }
        
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
        stack.addArrangedSubview(joinButton)
        stack.addArrangedSubview(createTeamButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        stack.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16).isActive = true
    }
    
    @objc func copyTap() {
        UIPasteboard.general.string = inviteLabel.text
        self.stack.insertArrangedSubview(copyLabel, at: 6)
        self.copyLabel.alpha = 1
        DispatchQueue.main.async {
            UIView.animate(withDuration: 3, animations: {
                self.copyLabel.alpha = 0
            }) { _ in
                self.stack.removeArrangedSubview(self.copyLabel)
                self.copyLabel.removeFromSuperview()
            }
        }
    }
    
    lazy var copyLabel: UILabel = {
        let copyLabel = UILabel(frame: .zero)
        copyLabel.backgroundColor = .lightGray
        copyLabel.layer.cornerRadius = 5
        copyLabel.layer.masksToBounds = true
        copyLabel.text = "Код скопирован в буфер обмена"
        return copyLabel
    }()
    
    @objc func createTeam() {
        let id = UserDefaults.standard.string(forKey: "id")
        guard let userId = id else {
            let alert = UIAlertController(title: "Команда", message: "Чтобы создать команду авторизируйтесь", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let alertController = UIAlertController(title: "Создать команду", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Создать", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                let invite = self.randomString(length: 13)
                NetworkManager().addTeam(name: text, id: userId, invite: invite) { (response, _) in
                    if response?.success == 1 {
                        DispatchQueue.main.async {
                            UserDefaults.standard.set("brib", forKey: "teamID")
                            self.updateController()
                        }
                    } else if response?.success == 2 {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Команда", message: "Введенное название уже занято", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else if response?.success == 3 {
                        self.createTeam()
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Введите название команды"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func joinTeam() {
        let id = UserDefaults.standard.string(forKey: "id")
        guard let userId = id else {
            let alert = UIAlertController(title: "Команда", message: "Чтобы стать участником команды авторизируйтесь", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let alertController = UIAlertController(title: "Присоединиться к команде", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Присоединиться", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                NetworkManager().addUserToTeam(id: userId, invite: text) { (response, error) in
                    if response?.success == 1 {
                        UserDefaults.standard.set("brib", forKey: "teamID")
                        self.updateController()
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Введите пригласительный код"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func randomString(length: Int) -> String {
        let letters = "0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
