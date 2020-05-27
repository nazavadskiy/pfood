//
//  MainNavigationBar.swift
//  Main Project
//
//  Created by Gagik on 09.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

//extension UINavigationBar {
class MainNavigationBar: UINavigationBar {
    
    var leftButton: UIView
    var rightButton: UIView
    var centerView: UIView

    public let sumLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        leftButton = UIView(frame: .zero)
        rightButton = UIView(frame: .zero)
        centerView = UIView(frame: .zero)
        
        super.init(frame: frame)
                
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(centerView)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        centerView.translatesAutoresizingMaskIntoConstraints = false
        
        leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        leftButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        leftButton.widthAnchor.constraint(equalTo: leftButton.heightAnchor).isActive = true
        
        rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        rightButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        rightButton.widthAnchor.constraint(equalTo: rightButton.heightAnchor).isActive = true
        
        centerView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor).isActive = true
        centerView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor).isActive = true
        centerView.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 100).isActive = true
        centerView.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor).isActive = true
        centerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setLeftButton(_ view: UIView?) {
        leftButton.subviews.forEach { $0.removeFromSuperview() }
        guard let view = view else { leftButton.isUserInteractionEnabled = false; return }
        
        leftButton.isUserInteractionEnabled = true
        leftButton.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.leadingAnchor.constraint(equalTo: leftButton.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: leftButton.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: leftButton.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: leftButton.bottomAnchor).isActive = true
    }
    
    func setRightButton(_ view: UIView?) {
        rightButton.subviews.forEach { $0.removeFromSuperview() }
        guard let view = view else { return }
        
        rightButton.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.leadingAnchor.constraint(equalTo: rightButton.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: rightButton.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: rightButton.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: rightButton.bottomAnchor).isActive = true
    }
    
    func setCenterView(_ view: UIView?) {
        centerView.subviews.forEach { $0.removeFromSuperview() }
        guard let view = view else { return }
        
        let imageView = UIImageView(image: UIImage(named: "shopicon"))
        imageView.contentMode = .scaleAspectFit
        centerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: centerView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor).isActive = true
        
        sumLabel.frame = imageView.bounds
        sumLabel.textAlignment = .center
        sumLabel.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        sumLabel.text = String(ShoppingCart.shared.getSum())
        sumLabel.textColor = .black
        imageView.addSubview(sumLabel)
        
        
        centerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: centerView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: centerView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: centerView.bottomAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 2).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
