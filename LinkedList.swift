import Foundation

public class Node<Value> {
    public var value: Value
    public var next: Node?
    
    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next) + " "
    }
}

let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)

node1.next = node2
node2.next = node3

print(node1)

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
            push(value)
            return
        }
        
        tail!.next = Node(value: value)
        
        tail = tail!.next
    }
    
    public func node(at index: Int) -> Node<Value>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    public mutating func insert(_ value: Value, 
                                after node: Node<Value>) 
                                -> Node<Value> {
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }          
    
    
    //Remove values from the list
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        
        return head?.value
    }
    
    public mutating func removeLast() -> Value? {
        guard let head = head else {
            return nil
        }
        
        guard head !== tail else {
            return pop()
        }
        
        var currentNode = head
        var prev = head 
        
        while let next = currentNode.next {
            prev = currentNode
            currentNode = next
        }
        
        tail = prev
        prev.next = nil
        
        return currentNode.value
    }
    
    public mutating func remove(after node: Node<Value>) -> Value? {
        // var value = node.next?.value
        // if node.next === tail {
        //     tail = node
        // }
        // node.next = node.next?.next
        // return value
        
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        
        return node.next?.value
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

var list = LinkedList<Int>()

list.push(1)
list.push(2)
list.push(3)
print(list)

print("Before inserting: \(list)")
var middleNode = list.node(at: 1)!
for _ in 1...4 {
    middleNode = list.insert(-1, after: middleNode)
}
print("After inserting: \(list)")

print("Before popping list: \(list)")
print(list.pop() ?? 0)
print("After popping list: \(list)")

print("Before remove last: \(list)")
print(list.removeLast() ?? 0)
print("After remove last: \(list)")

print("Before remove after: \(list)")
let index = 0
let node = list.node(at: index)!
print(list.remove(after: node) ?? 0)
print("After remove after: \(list)")


//Custom collection indexes
extension LinkedList: Collection {
    public struct Index: Comparable {
        public var node: Node<Value>?
        
        static public func ==(lhs: Index, rhs: Index) -> Bool  {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            
            //sequence(first:next:)
            //Returns a sequence formed from first and repeated lazy applications of next.
            //first: The first element to be returned from the sequence.
            //next: A closure that accepts the previous sequence element and returns the next element.
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    public var startIndex: Index {
        return Index(node: head)
    }
    
    public var endIndex: Index {
        return Index(node: tail)
    }
    
    public subscript(position: Index) -> Value {
        return position.node!.value
    }
    
    public func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }
}

//Example of using Collection

var collectionList = LinkedList<Int>()
for i in 0...9 {
    collectionList.append(i)
}

print("List: \(collectionList)")
print("First element: \(collectionList[collectionList.startIndex])")
print("Array containing first 3 elements: \(Array(collectionList.prefix(3)))")
print("Array containing last 3 elements: \(Array(collectionList.suffix(3)))")

let sum = collectionList.reduce(0, +)
print("Sum of all values: \(sum)")
