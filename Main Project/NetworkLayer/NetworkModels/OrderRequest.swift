//
//  Order.swift
//  Main Project
//
//  Created by Gagik on 20.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

public class OrderRequest: Decodable {
    var address: String
    var comment: String
    var cook: String
    var courier: String
    var foodCart: [String]
    var name: String
    var paymentType: String
    var phone: String
    var price: String
    var status: String
    var completeTime: String
    var deliveredTime: String
    var orderTime: String
    var pickedUpTime: String
    var id: String = "0"
    
    
    init(address: String, comment: String, cook: String, courier: String, foodCart: [String], name: String, paymentType: String, phone: String, price: String, status: String, completeTime: String, deliveredTime: String, orderTime: String, pickedUpTime: String, id: String) {
        self.address = address
        self.comment = comment
        self.cook = cook
        self.courier = courier
        self.foodCart = foodCart
        self.name = name
        self.paymentType = paymentType
        self.phone = phone
        self.price = price
        self.status = status
        self.completeTime = completeTime
        self.deliveredTime = deliveredTime
        self.orderTime = orderTime
        self.pickedUpTime = pickedUpTime
        self.id = id
    }
    
//    func createDictionary() -> Dictionary<String, Any>{
//        let a = [
//            "name" : name,
//            "address" : address,
//            "phone" : phone,
//            "price" : price,
//            "time" : time,
//            "payment_type" : paymentType,
//            "order_p" : foodCart,
//            "complete_time" : completeTime,
//            "status" : status,
//            "key" : "gDjRtEYOTwqW0w@ezsVn",
//            ] as [String : Any]
//        return a
//    }


    
    
//    private enum ApiResponseCodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case address = "address"
//        case phone = "phone"
//        case price = "price"
//        case time = "time"
//        case paymentType = "payment_type"
//        case foodCart = "order_p"
//        case comment = "comment"
//    }
//
//    required public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
//
//        id = try container.decode(String.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        address = try container.decode(String.self, forKey: .address)
//        phone = try container.decode(String.self, forKey: .phone)
//        price = try container.decode(String.self, forKey: .price)
//        time = try container.decode(String.self, forKey: .time)
//        paymentType = try container.decode(String.self, forKey: .paymentType)
//        foodCart = try container.decode([String].self, forKey: .foodCart)
//        completeTime = ""
//        status = ""
//        do {
//            comment = try container.decode(String.self, forKey: .comment)
//        } catch { comment = "" }
//    }
}

