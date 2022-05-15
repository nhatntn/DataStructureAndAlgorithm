import Foundation

public class BinaryNode<Element> {
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(value: Element) {
        self.value = value
    }
}

var tree: BinaryNode<Int> {
    let zero = BinaryNode(value: 0)
    let one = BinaryNode(value: 1)
    let five = BinaryNode(value: 5)
    let seven = BinaryNode(value: 7)
    let eight = BinaryNode(value: 8)
    let nine = BinaryNode(value: 9)
    let ten = BinaryNode(value: 10)
    let elevent = BinaryNode(value: 11)
    let twelve = BinaryNode(value: 12)
    let thirteen = BinaryNode(value: 13)
    seven.leftChild = one
    one.leftChild = zero
    one.rightChild = five
    seven.rightChild = nine
    nine.leftChild = eight
    eight.leftChild = ten
    eight.rightChild = elevent
    elevent.rightChild = twelve
    twelve.leftChild = thirteen
    return seven
}

extension BinaryNode: CustomStringConvertible {
    
    public var description: String {
        return diagram(for: self)
    }
    
    private func diagram(for node: BinaryNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }                        
        
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        
        return diagram(for: node.rightChild,
                       top + "  ", top + "┌────", top + "| ")
                       + root + "\(node.value)\n"
                       + diagram(for: node.leftChild,
                                 bottom + "| ", bottom + "└────", bottom + "  ")
    }
}

print(tree)

extension BinaryNode {
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
        
    }
    
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}

print("-------In-order traversal-------")
tree.traverseInOrder {
    print($0)
}

print("-------Pre-order traversal-------")
tree.traversePreOrder {
    print($0)
}

print("-------Post-order traversal-------")
tree.traversePostOrder {
    print($0)
}
