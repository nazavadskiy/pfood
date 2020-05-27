//
//  ShoppingCartPlaceholderModel.swift
//  Main Project
//
//  Created by Тимур Бакланов on 08.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

enum ShoppingCartPlaceholderModel {
    case order, delivery, sum
    
    var text: String {
        switch self {
        case .order:
            return "Заказ"
        case .delivery:
            return "Доставка"
        case .sum:
            return "Итого"
        }
    }
}
