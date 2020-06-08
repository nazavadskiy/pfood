//
//  Router.swift
//  Main Project
//
//  Created by Gagik on 09.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

protocol HamburgerRouterProtocol: class {
    func openHambergerMenu()
    func openProfile()
    func openMenu()
    func openShoppingCart()
    func openRaiting()
    func openOrders()
}

class HamburgerRouter {
    
    weak var controller: ViewController?
    
    lazy var menuCoordinator: CoordinatorProtocol = {
        let menuCoordinator = MenuCoordinator()
        menuCoordinator.hamburgerRouter = self
        return menuCoordinator
    }()
    
    lazy var profileCoordinator: CoordinatorProtocol = {
        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.hamburgerRouter = self
        return profileCoordinator
    }()
    
    lazy var raitingCoordinator: RaitingsCoordinator = {
        let raitingCoordinator = RaitingsCoordinator()
        raitingCoordinator.hamburgerRouter = self
        return raitingCoordinator
    }()
    
    lazy var shoppingCartCoordinator: ShoppingCartCoordinator = {
        let shoppingCartCoordinator = ShoppingCartCoordinator()
        shoppingCartCoordinator.hamburgerRouter = self
        return shoppingCartCoordinator
    }()
    
    lazy var orderCoordinator: OrdersCoordinator = {
           let orderCoordinatir = OrdersCoordinator()
           orderCoordinatir.hamburgerRouter = self
           return orderCoordinatir
       }()
}

//MARK: HomeControllerDelegate
extension HamburgerRouter: HamburgerMenuDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOptionModel?) {
        controller?.closeHumburgerMenu { _ in
            guard let menuOption = menuOption else { return }
            switch menuOption {
            case .Profile:
                self.openProfile()
            case .Menu:
                self.openMenu()
            case .ShoppingCard:
                self.openShoppingCart()
            case .Ratings:
                self.openRaiting()
            case .Orders:
                self.openOrders()
            }
        }
    }
    
    func openAuthVC() {
        controller?.setCenterController(profileCoordinator.mainVC)
        ((profileCoordinator.mainVC as? UINavigationController)?.topViewController as? ProfileController)?.openNewVC()
    }
}

extension HamburgerRouter: HamburgerRouterProtocol {
    
    func openHambergerMenu() {
        if controller!.closed {
            controller?.openHambergerMenu()
        } else {
            controller?.closeHumburgerMenu()
        }
        controller!.closed = !(controller!.closed)
    }
    
    func openProfile() {
        controller?.setCenterController(profileCoordinator.mainVC)
        controller?.closed = true
    }
    func openMenu() {
        controller?.setCenterController(menuCoordinator.mainVC)
        controller?.closed = true
    }
    func openShoppingCart() {
        controller?.openHambergerMenu()
        controller?.setCenterController(shoppingCartCoordinator.mainVC)
        controller?.closed = true
    }
    func openRaiting() {
        controller?.setCenterController(raitingCoordinator.mainVC)
        controller?.closed = true
    }
    
    func openOrders() {
        controller?.setCenterController(orderCoordinator.mainVC)
        controller?.closed = true
    }
}
