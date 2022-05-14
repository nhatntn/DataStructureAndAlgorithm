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
        return array.popLast()
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
