//  Created by nhatnt on 23/04/2021.
import Foundation

public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?

    public init() {}
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        guard !isEmpty else {
            self.push(value)
            return
        }
        tail?.next = Node(value: value)
        tail = tail?.next
    }
    
    public func node(at index: Int) -> Node<Value>? {
        var currentIndex = 0
        var currentNode = head
        
        while currentIndex < index && currentNode?.next != nil {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    public mutating func insert(_ value: Value,
                                after node: Node<Value>) -> Node<Value> {
        // 2
        guard tail !== node else {
            append(value)
            return tail!
        }
        // 3
        node.next = Node(value: value, next: node.next)
        return node.next!
    }

}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        
        return String(describing: head)
    }
}
