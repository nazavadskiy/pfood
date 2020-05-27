//
//  EatingMenuModel.swift
//  Main Project
//
//  Created by Тимур Бакланов on 08.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

enum EatingMenuModel: Int, CustomStringConvertible, CaseIterable {
    var description: String {
        switch self {
        case .boxes: return "Боксы"
        case .meat: return "Мясо и гарниры из тандыра"
        case .peeta: return "Пита"
        case .roll: return "Роллы"
        case .souce: return "Соусы"
        }
    }
    
    case boxes, meat, peeta, roll, souce
    
}
