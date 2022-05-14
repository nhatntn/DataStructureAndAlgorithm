import Foundation

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool {get}
    var peek: Element? {get}
}

//Array-base implementation
public struct QueueArray<T>: Queue {
    private var array: [T] = []
    public init() {}
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var peek: T? {
        return array.first
    }
    
    public mutating func enqueue(_ value: T) -> Bool {
        array.append(value)
        return true
    }
    
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        return array.description
    }
}


//Using queue array (array-base implementation)

var queue = QueueArray<String>()
_ = queue.enqueue("Nguyen")
_ = queue.enqueue("Tai")
_ = queue.enqueue("Nhat")

print("\(queue)")

print("Dequeue: \(queue.dequeue() ?? "")")
print("After dequeue: \(queue)")

print("Peek: \(queue.peek ?? "")")

//Double Stack Implementation

public struct QueueStack<T>: Queue {
    private var leftStack = [T]()
    private var rightStack = [T]()
    
    public init() {}
    
    public var isEmpty: Bool {
        return leftStack.isEmpty && rightStack.isEmpty
    }
    
    public var peek: T? {
        return !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        
        return leftStack.popLast()
    }
}


extension QueueStack: CustomStringConvertible {
    public var description: String {
        let printList = leftStack.reversed() + rightStack
        return printList.description
    }
}

var queueStack = QueueStack<String>()
_ = queueStack.enqueue("Nguyen")
_ = queueStack.enqueue("Tai")
_ = queueStack.enqueue("Nhat")

print("\(queueStack)")

print("Dequeue: \(queueStack.dequeue() ?? "")")
print("After dequeue: \(queueStack)")

print("Peek: \(queueStack.peek ?? "")")
