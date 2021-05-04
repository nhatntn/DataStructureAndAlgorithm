//  Created by nhatnt on 23/04/2021.

example(of: "creating and linking nodes") {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    node1.next = node2
    node2.next = node3
    print(node1)
}

example(of: "inserting at a particular index") {
    var list = LinkedList<Int>()
    
    list.push(1)
    list.push(2)
    list.push(3)
    
    print("Before inserting: \(list)")
    let middleNode = list.node(at: 1)
    for _ in 1...4 {
        guard var tempNode = middleNode else {
            return
        }
        tempNode = list.insert(-1, after: tempNode)
    }
    
    print("After inserting: \(list)")
}
