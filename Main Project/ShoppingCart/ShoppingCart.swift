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
    //lazy var currentOrder: OrderRequest? = self.fetchOrder()
    
    
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
    
    //MARK: - sending order
    
    @objc public func sendOrder(paymentType: String, adressZakaz: String) {
        var order: [String] = []
        var i = 0
        for (item, count) in items {
            i += 1
            if count == 0 { continue }
            order.append(item.name + " " + String(count) + "шт.")
        }
        
        guard let id = UserDefaults.standard.string(forKey: "id") else { return }
        userRef.child(id).observe(.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? "Name"
            let adress = value?["address"] as? String ?? "Address"
            let df = DateFormatter()
            df.dateFormat = "HH:mm:ss"
            let now = df.string(from: Date())
            let phone = UserDefaults.standard.string(forKey: "phone")
            let comment = value?["comment"] as? String ?? ""

            let order = OrderRequest(address: adress,
                                     comment: comment,
                                     cook: nil,
                                     courier: nil,
                                     foodCart: order,
                                     name: name,
                                     paymentType: paymentType,
                                     phone: phone ?? "",
                                     price: String(self.getSum()),
                                     status: "0",
                                     completeTime: nil,
                                     deliveredTime: nil,
                                     orderTime: now,
                                     pickedUpTime: nil,
                                     id: "")
           
            //self.saveOrder(with: order)
            
            let orderToSend: [String: Any] = [
                "address" : order.address,
                "comment" : order.comment,
                "name" : order.name,
                "foodCart" : order.foodCart,
                "paymentType" : order.paymentType,
                "phone" : order.phone,
                "price" : order.price,
                "status" : order.status,
                "cook" : order.cook as Any,
                "courier" : order.courier as Any
            ]
            
            let timeToSend: [String: Any] = [
                "orderTime" : order.orderTime,
                "completeTime" : order.completeTime as Any,
                "deliveredTime" : order.deliveredTime as Any,
                "pickedUpTime" : order.pickedUpTime as Any
            ]
            
            let df1 = DateFormatter()
            df1.dateFormat = "yy\\MM\\dd"
            let nowDate = df1.string(from: Date())
            
            let ordRef = Database.database().reference()
            
            ordRef.child("orders").observeSingleEvent(of: .value, with: { (snapshot) in
                snapshot.children.suffix(1).forEach({ (child) in
                    if let child = child as? DataSnapshot {
                        var newOrderNumber = (Int(child.key.suffix(3)) ?? -1) + 1
                        
                        let ind = child.key.firstIndex(of: " ") ?? child.key.endIndex
                        if child.key[..<ind] != nowDate {
                            newOrderNumber = 0
                        }
                           
                        self.orderRef.child("\(nowDate)_\(String(format: "%03d",newOrderNumber))").setValue(orderToSend)
                        self.orderRef.child("\(nowDate)_\(String(format: "%03d",newOrderNumber))/time").setValue(timeToSend)
                    }
                })
            })
            //MARK: - here new orders to top
        }
    }
    
    
    
    
//    func saveOrder(with order: OrderRequest) {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        guard let entity = NSEntityDescription.entity(forEntityName: "Order", in: context) else { return }
//        let model = Order(entity: entity, insertInto: context)
//
//        model.name = order.name
//        model.address = order.address
//        model.phone = order.phone
//        model.price = order.price
//        model.time = order.time
//        model.paymentType = order.paymentType
//        model.order = order.foodCart
//        model.completeTime = order.completeTime
//        model.status = order.status
//
//        do {
//            try context.save()
//        } catch let error as NSError{
//            print(error.localizedDescription)
//        }
//    }
    
//    func fetchOrder() -> OrderRequest? {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
//
//        do {
//            let result = try context.fetch(fetchRequest)
//            if result.isEmpty { return nil }
//
//
//            let order = OrderRequest(name: result.first?.name ?? "",
//                                     address: result.first?.address  ?? "",
//                                     phone: result.first?.phone ?? "",
//                                     price: result.first?.price  ?? "",
//                                     time: result.first?.time  ?? "",
//                                     paymentType: result.first?.paymentType  ?? "",
//                                     foodCart: result.first?.order  ?? "",
//                                     completeTime: result.first?.completeTime  ?? "",
//                                     status: result.first?.status  ?? "", id: "")
//            return order
//        } catch let error as NSError{
//            print(error.localizedDescription)
//        }
//        return nil
//    }
    
}
