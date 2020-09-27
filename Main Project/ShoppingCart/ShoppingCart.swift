//
//  ShoppingCart.swift
//  Main Project
//
//  Created by Gagik on 16.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import CoreData

class ShoppingCart {
    
    var deliveryCost = 200
    var freeDeliveryCost = 1000
    
    init() {
        let ref = Database.database().reference().child("delivery_settings")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.deliveryCost = value?["delivery_cost"] as? Int ?? 200
            self.freeDeliveryCost = value?["free_delivery_cost"] as? Int ?? 1000
        }
    }
    
    var userRef = Database.database().reference().child("users")
    var orderRef = Database.database().reference().child("orders")
    
    static let shared = ShoppingCart()
    
    var items: [NextMenuModel: Int] = [:]
    lazy var currentOrder: OrderRequest? = self.fetchOrder()
    
    
    func increaseItemCount(_ item: NextMenuModel) {
        if let count = items[item] {
            items[item] = count + 1
        } else {
            items[item] = 1
        }
        
        if let topVC = UIApplication.shared.windows[0].rootViewController as? ViewController {
            guard let topVC = topVC.centerController as? UINavigationController else { return }
            if let navConrol = topVC.navigationBar as? MainNavigationBar {
                navConrol.sumLabel.text = String(getSum())
                DispatchQueue.main.async {
                    navConrol.sumLabel.frame.origin.y -= 8
                    UIView.animate(withDuration: 0.3) {
                        navConrol.sumLabel.frame.origin.y += 8
                    }
                }
            }
        }
    }
    
    func decreaseItemCount(_ item: NextMenuModel) {
        if let count = items[item], count > 0 {
            items[item] = count - 1
        }
        
        if let topVC = UIApplication.shared.windows[0].rootViewController as? ViewController {
            guard let topVC = topVC.centerController as? UINavigationController else { return }
            if let navConrol = topVC.navigationBar as? MainNavigationBar {
                navConrol.sumLabel.text = String(getSum())
                DispatchQueue.main.async {
                    navConrol.sumLabel.frame.origin.y -= 8
                    UIView.animate(withDuration: 0.3) {
                        navConrol.sumLabel.frame.origin.y += 8
                    }
                }
            }
        }
    }
    
    func getSum() -> Int {
        var sum = 0
        for (item, count) in items {
            sum += item.price * count
        }
        return sum
    }
    
    func deliveryPrice() -> Int {
                
        if getSum() > freeDeliveryCost {
            return 0
        }
        return deliveryCost
    }
    
    
    @objc public func sendOrder(paymentType: String, adressZakaz: String) {
        var order = ""
        var i = 0
        for (item, count) in items {
            i += 1
            if count == 0 { continue }
            order += item.name + " " + String(count) + "шт. | "
        }
        
        guard let id = UserDefaults.standard.string(forKey: "id") else { return }
        userRef.child(id).observe(.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? "Name"
            let adress = value?["address"] as? String ?? "Adress"
            let df = DateFormatter()
            let closeDate = Date().addingTimeInterval(10)
            df.dateFormat = "HH:mm:ss"
            let now = df.string(from: Date())
            let close = df.string(from: closeDate)
            let phone = UserDefaults.standard.string(forKey: "phone")

            let order = OrderRequest(name: name,
                                     address: adress,
                                     phone: phone ?? "",
                                     price: String(self.getSum()),
                                     time: now,
                                     paymentType: paymentType,
                                     orderP: order,
                                     completeTime: close,
                                     status: "0", id: "")
           
            self.saveOrder(with: order)
            
            let orderToSend: [String: Any] = [
                "address" : order.address,
                "comment" : order.comment ?? "",
                "completeTime" : order.completeTime,
                "name" : order.name,
                "orderP" : order.orderP,
                "paymentType" : order.paymentType,
                "phone" : order.phone,
                "price" : order.price,
                "status" : "Получен",
                "time" : order.time
            ]
            
            self.orderRef.child("orders_\(Int.random(in: 0...10000))").setValue(orderToSend)
        }
    }
    
    
    
    
    func saveOrder(with order: OrderRequest) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Order", in: context) else { return }
        let model = Order(entity: entity, insertInto: context)
        
        model.name = order.name
        model.address = order.address
        model.phone = order.phone
        model.price = order.price
        model.time = order.time
        model.paymentType = order.paymentType
        model.order = order.orderP
        model.completeTime = order.completeTime
        model.status = order.status
        
        do {
            try context.save()
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func fetchOrder() -> OrderRequest? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
        
        do {
            let result = try context.fetch(fetchRequest)
            if result.isEmpty { return nil }
            
            
            let order = OrderRequest(name: result.first?.name ?? "",
                                     address: result.first?.address  ?? "",
                                     phone: result.first?.phone ?? "",
                                     price: result.first?.price  ?? "",
                                     time: result.first?.time  ?? "",
                                     paymentType: result.first?.paymentType  ?? "",
                                     orderP: result.first?.order  ?? "",
                                     completeTime: result.first?.completeTime  ?? "",
                                     status: result.first?.status  ?? "", id: "")
            return order
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        return nil
    }
    
}
