//
//  ViewController.swift
//  AnimationDemo
//
//  Created by Nickolai Nikishin on 29.01.22.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    @IBOutlet weak var lottieView: AnimationView!
    
    var animateButton: UIButton?
    var animateView: UIView?
    var angle: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .custom)
        var centerPoint = view.center
        centerPoint.y = view.bounds.height - 50
        button.center = centerPoint
        button.setTitle("Animate", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        button.backgroundColor = .blue
        view.addSubview(button)
        
        animateButton = button
    }

    @objc func buttonTapped() {
        let start = self.lottieView.center

        UIView.animateKeyframes(withDuration: 5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.lottieView.transform = CGAffineTransform(scaleX: 2, y: 2)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.lottieView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.maxY)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.lottieView.center = CGPoint(x: self.view.bounds.width, y: start.y)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.lottieView.center = start
                self.lottieView.transform = .identity
            }
        })
    }

    func animate(progress: AnimationProgressTime) {
        
        
        lottieView.play()
    }
}

