//
//  MenuNavigator.swift
//  Main Project
//
//  Created by Gagik on 09.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class MenuCoordinator: CoordinatorProtocol{
    
    let mainVC: UIViewController
    weak var hamburgerRouter: HamburgerRouterProtocol?
    
    init() {
        
        let rootVC = MenuViewController()
        let navigationController = UINavigationController(navigationBarClass: MainNavigationBar.self, toolbarClass: nil)
        navigationController.pushViewController(rootVC, animated: true)
        mainVC = navigationController
        
        rootVC.barDelegate = self
    }
    
    @objc func openHamburgerAction() {
        hamburgerButtonDidTap()
    }
    
    @objc func openShoppingCardAction() {
        if let rootVC = UIApplication.shared.windows.first?.rootViewController as? ViewController {
            rootVC.hamburgerMenuController.delegate?.handleMenuToggle(forMenuOption: MenuOptionModel.ShoppingCard)
        }

        shoppingCartButtonDidTap()
    }
}

// MARK: MenuControllerDelegate
extension MenuCoordinator: MenuControllerDelegate {
    func hamburgerButtonDidTap() {
        hamburgerRouter?.openHambergerMenu()
    }
    
    func shoppingCartButtonDidTap() {
        
    }
}
