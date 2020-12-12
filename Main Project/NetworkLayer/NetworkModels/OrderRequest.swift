//
//  Order.swift
//  Main Project
//
//  Created by Gagik on 20.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

public class OrderRequest: Decodable {
    var id: String = "0"
    var name: String
    var address: String
    var phone: String
    var price: String
    var time: String
    var paymentType: String
    var foodCart: [String]
    var completeTime: String
    var status: String
    var comment: String?
    
    
    init(name: String, address: String, phone: String, price: String, time: String, paymentType: String, foodCart: [String], completeTime: String, status: String, id: String) {
        self.name = name
        self.address = address
        self.phone = phone
        self.price = price
        self.time = time
        self.paymentType = paymentType
        self.foodCart = foodCart
        self.completeTime = completeTime
        self.status = status
        self.id = id
    }
    
    func createDictionary() -> Dictionary<String, Any>{
        let a = [
            "name" : name,
            "address" : address,
            "phone" : phone,
            "price" : price,
            "time" : time,
            "payment_type" : paymentType,
            "order_p" : foodCart,
            "complete_time" : completeTime,
            "status" : status,
            "key" : "gDjRtEYOTwqW0w@ezsVn",
            ] as [String : Any]
        return a
    }


    
    
    private enum ApiResponseCodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case address = "address"
        case phone = "phone"
        case price = "price"
        case time = "time"
        case paymentType = "payment_type"
        case foodCart = "order_p"
        case comment = "comment"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        phone = try container.decode(String.self, forKey: .phone)
        price = try container.decode(String.self, forKey: .price)
        time = try container.decode(String.self, forKey: .time)
        paymentType = try container.decode(String.self, forKey: .paymentType)
        foodCart = try container.decode([String].self, forKey: .foodCart)
        completeTime = ""
        status = ""
        do {
            comment = try container.decode(String.self, forKey: .comment)
        } catch { comment = "" }
    }
}

