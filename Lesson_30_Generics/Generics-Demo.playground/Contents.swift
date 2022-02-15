import UIKit

// What are generics?

func sayHello(toInt value: Int) {
    print("sayHello Int \(value)")
}

func sayHello(toDouble value: Double) {
    print("sayHello Double \(value)")
}

func sayHello(toFloat value: Float) {
    print("sayHello Float \(value)")
}

func sayHello(toString value: String) {
    print("sayHello String \(value)")
}

func sayHello<T>(to value: T) {
    print("sayHello Generic \(value)")
}

sayHello(to: 1)
sayHello(to: Double.pi)
sayHello(to: Float.pi)
sayHello(to: "String")

// Why not using Any instead of generics?

func sayHello(toAny value: Any) {
    print("sayHello Any \(value)")
}

sayHello(toAny: {})
sayHello(toAny: "String 2")

// Type Constraints

func add<T: Numeric>(a: T, b: T) -> T {
    return a + b
}

print(add(a: 2, b: 3.5))

// Generic Types

struct StackInt {
    var values: [Int] = []
    
    mutating func push(_ value: Int) {
        values.append(value)
    }
    
    mutating func pop() -> Int? {
        values.popLast()
    }
}

struct Stack<Element> {
    var values: [Element] = []
    
    mutating func push(_ value: Element) {
        values.append(value)
    }
    
    mutating func pop() -> Element? {
        values.popLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("hhh")

// Extending a generic type

extension Stack {
    var lastPushed: Element? {
        return values.last
    }
}

// assosiated types

protocol StackIntProtocol {
    var count: Int { get }
    mutating func push(_ value: Int)
    mutating func pop() -> Int
}

// - not allowed in swift
//protocol StackGenericsProtocol<Element> {
//    var count: Int { get }
//    mutating func push(_ value: Element)
//    mutating func pop() -> Element?
//}

protocol StackGenericsProtocol {
    associatedtype Element
    var count: Int { get }
    mutating func push(_ value: Element)
    mutating func pop() -> Element?
}

struct IntStack: StackGenericsProtocol {
//    typealias Element = Int
    
    private var values: [Int] = []
    var count: Int {
        return values.count
    }
    
    mutating func push(_ value: Int) {
        values.append(value)
    }
    mutating func pop() -> Int? {
        values.popLast()
    }
}

// Generic type with a protocol with associated type

struct MyStack<Item>: StackGenericsProtocol {
    typealias Element = Item
    
    private var values: [Item] = []
    var count: Int {
        return values.count
    }
    
    mutating func push(_ value: Item) {
        values.append(value)
    }
    mutating func pop() -> Item? {
        values.popLast()
    }
}

var stack3 = MyStack<String>()
stack3.push("Hello")
stack3.push("World")
stack3.push("Everybody!")

// Extending from a protocol with associated type
extension Array: StackGenericsProtocol {
    mutating func push(_ value: Element) {
        append(value)
    }
    
    mutating func pop() -> Element? {
        popLast()
    }
}

//How to solve "Protocol 'Stack' can only be used as a generic constraint ..."?
func executeOperation<Container: StackGenericsProtocol>(container: Container) {

}
// where clause
 
func insert<Container: StackGenericsProtocol, Value>(container: inout Container, value: Value) where Container.Element == Value {
    container.push(value)
}
