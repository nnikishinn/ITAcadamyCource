//
//  ViewController.swift
//  ArrayTest
//
//  Created by Nickolai Nikishin on 18.01.22.
//

import UIKit



class ViewController: UIViewController {
    var ofset = 25
    typealias MyString = String
    
    typealias VoidBlock = ()->()
    typealias ErrorBlock = (Error)->()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let completionBlock: ErrorBlock?
        
        let array: [Any] = ["A", 1, ViewController(), 2]
        
        var resultIteration: [Any] = []
        for element in array {
            if element is Int || element is ViewController {
                resultIteration.append(element)
            }
        }
        
        var result: [Any] = array.filter { $0 is Int || $0 is UIViewController}
        
        print(result)
        
        
        // Do any additional setup after loading the view.
    }

    override var description: String {
        return super.description + " ofset " + String(ofset)
    }
}

