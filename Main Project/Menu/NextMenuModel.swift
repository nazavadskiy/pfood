//
//  NextMenuModel.swift
//  Main Project
//
//  Created by Тимур Бакланов on 15.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation
import UIKit

class NextMenuModel {
    let description: String
    let imageURL: String
    let name: String
    let price: Int
    let products: String
    let sale: Bool
    
    var image: UIImage?
    
    init(description: String, imageURL: String, name: String, price: Int, products: String, sale: Bool) {
        self.description = description
        self.imageURL = imageURL
        self.name = name
        self.price = price
        self.products = products
        self.sale = sale
    }
}

extension NextMenuModel: Hashable {
    static func == (lhs: NextMenuModel, rhs: NextMenuModel) -> Bool {
        if lhs.name != rhs.name { return false }
        
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
