//
//  OrdersCoordinator.swift
//  Main Project
//
//  Created by Тимур Бакланов on 15.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class OrdersCoordinator: CoordinatorProtocol {
     let mainVC: UIViewController
            weak var hamburgerRouter: HamburgerRouterProtocol?
            
            init() {
                let rootVC = OrdersViewController()
                let navigationController = UINavigationController(navigationBarClass: MainNavigationBar.self, toolbarClass: nil)
                navigationController.pushViewController(rootVC, animated: true)
                mainVC = navigationController

                rootVC.barDelegate = self
            }
        }

    // MARK: MenuControllerDelegate
    extension OrdersCoordinator: RaitingsControllerDelegate {
            func hamburgerButtonDidTap() {
                hamburgerRouter?.openHambergerMenu()
            }
            
            func shoppingCartButtonDidTap() {
                
            }
}
