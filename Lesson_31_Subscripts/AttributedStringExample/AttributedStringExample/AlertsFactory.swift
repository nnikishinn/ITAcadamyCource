//
//  AlertsFactory.swift
//  AttributedStringExample
//
//  Created by Nickolai Nikishin on 19.02.22.
//

import UIKit

class AlertsFactory {
    static func makeDefaultAlert(vc: UIViewController? = nil) {
        let alert = UIAlertController(title: "Test", message: "Test", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        if let vc = vc {
            vc.present(alert, animated: true)
        } else {
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        }
    }
}
