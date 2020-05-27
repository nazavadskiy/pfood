//
//  LinkedList.swift
//  Main Project
//
//  Created by Gagik on 01.04.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

class Node<Element> {
    var value: Element
    var nextNode: Node?
    
    init(value: Element) {
        self.value = value
    }
}

class LinkedList<Element: Hashable> {
    var head: Node<Element>?
        
    func append(_ element: Element) {
        if head == nil { head = Node(value: element); return }
        var next = head
        while next?.nextNode != nil {
            next = next?.nextNode
        }
        next?.nextNode = Node(value: element)
    }
    
    func appendFirst(_ element: Element) {
        let node = Node(value: element)
        node.nextNode = head
        head = node
    }
    
    func removeDuplicats() {
        var dic = Dictionary<Element, Bool>()
        var next = self.head
        var prev = self.head
        
        while let node = next {
            next = node.nextNode
            
            if let _ = dic[node.value] {
                prev?.nextNode = node.nextNode
            } else {
                dic[node.value] = true
            }
            prev = node
        }
    }
    
    func isPolindrom() -> Bool {
        let reverseList = LinkedList<Element>()
        
        var next = head
        while let eNext = next {
            reverseList.appendFirst(eNext.value)
            next = eNext.nextNode
        }
        
        return false
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        var description = ""
        var next = head
        while let eNext = next {
            description += " \(eNext.value) "
            next = eNext.nextNode
        }
        return description
    }
}

extension LinkedList: Equatable where Element: Equatable{
    static func == (lhs: LinkedList<Element>, rhs: LinkedList<Element>) -> Bool {
        var rightHead = rhs.head
        var leftHead = lhs.head
        while let right = rightHead?.value, let left = leftHead?.value {
            guard right == left else {
                return false
            }
            rightHead = rightHead?.nextNode
            leftHead = leftHead?.nextNode
        }
        
        guard rightHead == nil && leftHead == nil else {
            return false
        }
        
        return true
    }
}

