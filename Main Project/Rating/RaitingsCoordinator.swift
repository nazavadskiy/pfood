//
//  RatingCoordinator.swift
//  Main Project
//
//  Created by Gagik on 09.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class RaitingsCoordinator: CoordinatorProtocol {
    
    let mainVC: UIViewController
        weak var hamburgerRouter: HamburgerRouterProtocol?
        
        init() {
            let rootVC = RaitingsViewController()
            let navigationController = UINavigationController(navigationBarClass: MainNavigationBar.self, toolbarClass: nil)
            navigationController.pushViewController(rootVC, animated: true)
            mainVC = navigationController

            rootVC.barDelegate = self
        }
    }

// MARK: MenuControllerDelegate
extension RaitingsCoordinator: RaitingsControllerDelegate {
        func hamburgerButtonDidTap() {
            hamburgerRouter?.openHambergerMenu()
        }
        
        func shoppingCartButtonDidTap() {
            
        }
    }
