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
    
    var closed = true
    
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
    
    @objc func swipeGesture(_ gestureRecognizer : UIPanGestureRecognizer) {
        self.view.endEditing(true)
        if gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: self.view).x
            
            if translation > 0 { //right
                guard let centerController = centerController else { return }
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    centerController.view.frame.origin.x = centerController.view.frame.width - 80
                }, completion: nil)
            } else { //left
                guard let centerController = centerController else { return }
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    centerController.view.frame.origin.x = 0
                }, completion: nil)
            }
            
        } //else if gestureRecognizer.state == .ended {
            
        //}

//        switch gestureRecognizer.state {
//        case .began:
//            guard let centerController = centerController else { return }
//            animator = UIViewPropertyAnimator(duration: 0.4, timingParameters: UISpringTimingParameters(mass: 0.2, stiffness: 50.0, damping: 7.0, initialVelocity: .zero))
//            animator.addAnimations {
//                centerController.view.frame.origin.x = centerController.view.frame.width - 80
//            }
//            animator.pauseAnimation()
//
//        case .changed:
//            animator.fractionComplete = gestureRecognizer.translation(in: view).x / view.bounds.size.width
//
//        case .ended:
//            if animator.fractionComplete <= 0.2 {
//                animator.isReversed = true
//            }
//
//            animator.startAnimation()
//
//        default:
//            ()
//        }
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
        self.view.endEditing(true)
        guard let centerController = centerController else { return }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            centerController.view.frame.origin.x = centerController.view.frame.width - 80
        }, completion: nil)
    }
    
    func closeHumburgerMenu(preparingAction: ((Bool) -> Void)? = nil) {
        preparingAction?(true)
        guard let centerController = centerController else { return }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            centerController.view.frame.origin.x = 0
        }, completion: nil)
    }
}

////MARK: HamburgerRouter
//extension ViewController: HamburgerRouter { }

