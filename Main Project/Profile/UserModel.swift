//
//  UserModel.swift
//  Main Project
//
//  Created by Тимур Бакланов on 15.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

class UserModel {
    let address: String
    let bonusesCount: Int
    let inviteCode: Int
    let monthRaiting: Int
    let monthRaitingPosition: Int
    let name: String
    let raiting: Int
    let raitingPosition: Int
    
    init(address: String, bonusesCount: Int, inviteCode: Int, monthRaiting: Int, monthRaitingPosition: Int, name: String, raiting: Int, raitingPosition: Int
 ) {
        self.address = address
        self.bonusesCount = bonusesCount
        self.inviteCode = inviteCode
        self.monthRaiting = monthRaiting
        self.monthRaitingPosition = monthRaitingPosition
        self.name = name
        self.raiting = raiting
        self.raitingPosition = raitingPosition
    }
    
    init(authData: UserModel) {
        address = authData.address
        bonusesCount = authData.bonusesCount
        inviteCode = authData.inviteCode
        monthRaiting = authData.monthRaiting
        monthRaitingPosition = authData.monthRaitingPosition
        name = authData.name
        raiting = authData.raiting
        raitingPosition = authData.raitingPosition
     }
}
