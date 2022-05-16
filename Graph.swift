import Foundation

public enum EdgeType {
    case directed
    case undirected
}

public protocol Graph {
    associatedtype T
    func createVertex(data: T) -> Vertex<T>
    func addDirectedEdge(from source: Vertex<T>,
                       to destination: Vertex<T>,
                       weight: Double?)
    func addUndirectedEdge(between source: Vertex<T>,
                           and destination: Vertex<T>,
                           weight: Double?)
    func add(_ edge: EdgeType, from source: Vertex<T>,
                               to destination: Vertex<T>,
                               weight: Double?)
    func edges(from source: Vertex<T>) -> [Edge<T>]
    func weight(from source: Vertex<T>,
                to destination: Vertex<T>) -> Double?
}

public struct Vertex<T> {
    public let index: Int
    public let data: T
}

extension Vertex: Hashable {
    public var hashValue: Int {
        return index.hashValue
    }

    public static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.index == rhs.index
    }
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(index): \(data)"
    }
}

public struct Edge<T> {
    public let source: Vertex<T>
    public let destination: Vertex<T>
    public let weight: Double?
}

public class AdjacencyList<T>: Graph {
    private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
    
    public init() {
        
    }
    
    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, data: data)
        adjacencies[vertex] = []
        return vertex
    }
    
    public func addDirectedEdge(from source: Vertex<T>, 
                                to destination: Vertex<T>,
                                weight: Double?) {
        let edge = Edge(source: source,
                        destination: destination,
                        weight: weight)
        adjacencies[source]?.append(edge)                                
    }
    
    public func addUndirectedEdge(between source: Vertex<T>,
                                  and destination: Vertex<T>,
                                  weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    public func add(_ edge: EdgeType, from source: Vertex<T>,
                                  to destination: Vertex<T>,
                                  weight: Double?) {
        switch edge {
            case .directed:
                addDirectedEdge(from: source, to: destination, weight: weight)
            case .undirected:
                addUndirectedEdge(between: source, and: destination, weight: weight)
        }                                  
    }

    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        return adjacencies[source] ?? []
    }
    
    public func weight(from source: Vertex<T>,
                       to destination: Vertex<T>) -> Double? {
        return edges(from: source)
        .first { $0.destination == destination }?
        .weight
    }

}
