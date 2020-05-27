//
//  ViewController.swift
//  Main Project
//
//  Created by Тимур Бакланов on 03.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    //MARK: - Properties
    var hamburgerMenuController: HamburgerController!
    var centerController: UIViewController?
    
    lazy var router: HamburgerRouter = {
        let router = HamburgerRouter()
        router.controller = self
        return router
    }()
    
    
    var startedLocation: CGPoint?
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHumburgerController()
        router.openMenu()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
        view.addGestureRecognizer(swipeGesture)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
    //MARK: - Handlers
    
    @objc func swipeGesture(_ gestureRecognizer : UISwipeGestureRecognizer) {        
        if gestureRecognizer.state == .began {
            startedLocation = gestureRecognizer.location(in: view)
        }
        
        if let startedLocation = startedLocation, gestureRecognizer.state == .ended {
            self.startedLocation = nil
            let location = gestureRecognizer.location(in: view)
            if startedLocation.y + 100 > location.y && startedLocation.y - 100 < location.y {
                if location.x - startedLocation.x > 100 {
                    self.openHambergerMenu()
                } else if startedLocation.x - location.x > 100 {
                    self.closeHumburgerMenu()
                }
            }
        }
    }

    func setCenterController(_ controller: UIViewController) {
        var oldFrame: CGRect = view.bounds
        if let centerController = centerController {
            oldFrame = centerController.view.frame
            centerController.willMove(toParent: nil)
            centerController.view.removeFromSuperview()
            centerController.removeFromParent()
        }
        
        if let controller = controller as? UINavigationController {
            controller.popToRootViewController(animated: true)
        }
        controller.view.frame = oldFrame
        view.addSubview(controller.view)
        addChild(controller)
        controller.didMove(toParent: self)
        centerController = controller
    }
    
    func configureHumburgerController() {
        hamburgerMenuController = HamburgerController()
        hamburgerMenuController.delegate = router
        view.insertSubview(hamburgerMenuController.view, at: 0)
        addChild(hamburgerMenuController)
        hamburgerMenuController.didMove(toParent: self)
    }
        
    // MARK: Open/Close Hamburger
    
    func openHambergerMenu() {
        guard let centerController = centerController else { return }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            centerController.view.frame.origin.x = centerController.view.frame.width - 80
        }, completion: nil)
    }
    
    func closeHumburgerMenu(preparingAction: ((Bool) -> Void)? = nil) {
        preparingAction?(true)
        guard let centerController = centerController else { return }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            centerController.view.frame.origin.x = 0
        }, completion: nil)
    }
}

////MARK: HamburgerRouter
//extension ViewController: HamburgerRouter { }

