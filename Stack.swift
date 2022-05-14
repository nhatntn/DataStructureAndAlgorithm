import Foundation

public struct Stack<Element> {
    private var storage = [Element]()
    
    public init() {}
    
    public init(_ elements: [Element]) {
        self.storage = elements
    }
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    } 
    
    public mutating func pop() -> Element? {
        return storage.popLast()
    }
    
    public func peek() -> Element? {
        return storage.last
    }
    
    public func isEmpty() -> Bool {
        // return storage.isEmpty
        return peek() != nil
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        let topDivider = "-----top-----\n"
        let endDivider = "\n-------------"
        
        let stackElements = storage.map {"\($0)"}.reversed().joined(separator: "\n")
        
        return topDivider + stackElements + endDivider
    }
}

//Using a stack
var stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)

print(stack)

if let poppedElement = stack.pop() {
    print("Popped: \(poppedElement)")
}

//initializing a stack from an array
let array = ["A", "B", "C", "D"]
var stackString = Stack(array)
print(stackString)
print("Popped: \(stackString.pop() ?? "")")

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.storage = elements
    }
}

//initializing a stack from an array literal
var stackLiteral: Stack = [1.0, 2.0, 3.0, 4.0]
print(stackLiteral)
