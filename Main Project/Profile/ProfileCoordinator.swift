//
//  ProfileCoordinator.swift
//  Main Project
//
//  Created by Gagik on 09.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class ProfileCoordinator: CoordinatorProtocol {
    
    let mainVC: UIViewController
    weak var hamburgerRouter: HamburgerRouterProtocol?
//    var closed: Bool
    
    init() {
        let rootVC = ProfileController()
        let navigationController = UINavigationController(navigationBarClass: MainNavigationBar.self, toolbarClass: nil)
        navigationController.pushViewController(rootVC, animated: true)
        mainVC = navigationController


        rootVC.barDelegate = self
    }
}

// MARK: MenuControllerDelegate
extension ProfileCoordinator: ProfileControllerDelegate {
    func hamburgerButtonDidTap() {
        hamburgerRouter?.openHambergerMenu()
    }
    
    func shoppingCartButtonDidTap() {
        
    }
}
