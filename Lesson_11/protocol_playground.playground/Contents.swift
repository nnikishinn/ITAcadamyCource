import UIKit

protocol Flyable {
    var hasWings: Bool { get set }
    func fly()
}

protocol Swimable {
    func swim()
}

extension Swimable {
    func swim() {
        print("I am swimming")
    }
}

protocol Populatable {
    func populate()
}


protocol RealDuck: Flyable, Swimable, Populatable {
   
}

protocol ToyDuck: Swimable {
    
}

struct Duck {
    var hasWings = true
}

extension Duck: RealDuck {
    
    func fly() {
        
    }
    
    func swim() {

    }
    
    func populate() {
        
    }
}

class ToyDuckObject {
    
}

extension ToyDuckObject: ToyDuck {
    func swim() {
        
    }
}
