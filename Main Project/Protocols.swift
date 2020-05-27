//
//  Protocols.swift
//  Main Project
//
//  Created by Тимур Бакланов on 04.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

protocol HamburgerMenuDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOptionModel?)
    
     func openAuthVC()
}
