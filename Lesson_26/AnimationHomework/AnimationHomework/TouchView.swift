//
//  TouchView.swift
//  AnimationHomework
//
//  Created by Nickolai Nikishin on 1.02.22.
//

import UIKit

class TouchView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began \(touches)")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches moved \(touches)")

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches ended \(touches)")

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches canceled \(touches)")

    }
}
