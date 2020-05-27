//
//  MenuModel.swift
//  Main Project
//
//  Created by Тимур Бакланов on 16.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit

class MenuModel {
    var name: String
    var imageURL: String
    var image: UIImage?
    
    init(name: String, imageURL: String) {
        self.name = name
        self.imageURL = imageURL
    }
}
