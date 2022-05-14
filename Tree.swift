import Foundation

public protocol Queue {
    associatedtype Element 
    var isEmpty: Bool { get }
    var peek: Element? { get }
    mutating func enqueue(_ value: Element) -> Bool
    mutating func dequeue() -> Element?
}

public struct QueueArray<T>: Queue {
    private var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var peek: Element? {
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

public class TreeNode<T> {
    public var value: T
    public var children: [TreeNode] = []
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func add(_ child: TreeNode) {
        children.append(child)
    }
}

let beverages = TreeNode("Beverages")

let hot = TreeNode("Hot")
let cold = TreeNode("Cold")

beverages.add(hot)
beverages.add(cold)

//make beverage tree 

func makeBeverageTree() -> TreeNode<String> {
    let tree = TreeNode("Beverages")
    
    let hot = TreeNode("hot")
    let cold = TreeNode("cold")

    let tea = TreeNode("tea")
    let coffee = TreeNode("coffee")
    let chocolate = TreeNode("cocoa")
    let blackTea = TreeNode("black")
    let greenTea = TreeNode("green")
    let chaiTea = TreeNode("chai")
    let soda = TreeNode("soda")
    let milk = TreeNode("milk")
    let gingerAle = TreeNode("ginger ale")
    let bitterLemon = TreeNode("bitter lemon")
    tree.add(hot)
    tree.add(cold)
    hot.add(tea)
    hot.add(coffee)
    hot.add(chocolate)
    cold.add(soda)
    cold.add(milk)
    tea.add(blackTea)
    tea.add(greenTea)
    tea.add(chaiTea)
    soda.add(gingerAle)
    soda.add(bitterLemon)
    
    return tree
}

//depth-first traversal 
extension TreeNode {
    public func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach {
            $0.forEachDepthFirst(visit: visit)
        }
    }
}

print("--------Depth-first traversal--------")
let treeDepthFirst = makeBeverageTree()
treeDepthFirst.forEachDepthFirst {
    print($0.value)
}

//level-order traversal
extension TreeNode {
    public func forEachLevelOrder(visit: (TreeNode) -> Void) {
        visit(self)
        
        var queue = QueueArray<TreeNode>()
        children.forEach {
            _ = queue.enqueue($0)
        }
        
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach {
                _ = queue.enqueue($0)
            }
        }
    }
}

print("--------Level Order traversal--------")
let treeLevelOrder = makeBeverageTree()
treeLevelOrder.forEachLevelOrder { print($0.value) }

print("--------Search--------")
extension TreeNode where T: Equatable {
    public func search(_ value: T) -> TreeNode? {
        var result: TreeNode?
        forEachDepthFirst { node in
            if node.value == value {
                result = node
            }
        }
        
        return result
    }
}

if let searchResult1 = treeDepthFirst.search("ginger ale") {
    print("Found node: \(searchResult1.value)")
} else {
    print("Couldn't find ginger ale")
}

if let searchResult2 = treeDepthFirst.search("WKD Blue") {
    print("Found node: \(searchResult2.value)")
} else {
    print("Couldn't find WKD Blue")
}
