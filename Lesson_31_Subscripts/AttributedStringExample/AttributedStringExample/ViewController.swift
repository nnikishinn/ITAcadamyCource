//
//  ViewController.swift
//  AttributedStringExample
//
//  Created by Nickolai Nikishin on 19.02.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        label.numberOfLines = 0
        let attributedString = NSMutableAttributedString(string: "Want to learn iOS? You should visit the best source of free iOS tutorials!")
        attributedString.addAttribute(.link, value: "https://www.hackingwithswift.com", range: NSRange(location: 19, length: 55))
        
        textView.attributedText = attributedString
        
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)

//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
//            AlertsFactory.makeDefaultAlert()
//        }
        

    }
    
    @objc func fireTimer() {
        AlertsFactory.makeDefaultAlert()
    }
    
    @IBAction func presentButtonTapped(_ sender: Any) {
//        AlertsFactory.makeDefaultAlert()
        timer?.invalidate()
    }
    

}

