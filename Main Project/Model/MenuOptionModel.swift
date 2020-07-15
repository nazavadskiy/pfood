//
//  MenuOptionModel.swift
//  Main Project
//
//  Created by Тимур Бакланов on 04.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

enum MenuOptionModel: Int, CustomStringConvertible {
    case Profile
    case Menu
    case ShoppingCard
//    case Ratings //this must be uncommented if Ratings come back to app
    case Orders
    
    var description: String {
        switch self {
        case .Profile: return "Профиль"
        case .Menu: return "Меню"
        case .ShoppingCard: return "Корзина"
//        case .Ratings: return "Рейтинг"
        case .Orders: return "Заказ"
        }
    }
    
    var image: String {
        switch self {
        case .Profile: return "User"
        case .Menu: return "Folk and spoon"
        case .ShoppingCard: return "Cart"
//        case .Ratings: return "Globe"
        case .Orders: return "Bag"
        }
    }
}
