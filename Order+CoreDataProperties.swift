//
//  Order+CoreDataProperties.swift
//  Main Project
//
//  Created by Gagik on 24.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var phone: String?
    @NSManaged public var price: String?
    @NSManaged public var time: String?
    @NSManaged public var paymentType: String?
    @NSManaged public var order: String?
    @NSManaged public var completeTime: String?
    @NSManaged public var status: String?

}
