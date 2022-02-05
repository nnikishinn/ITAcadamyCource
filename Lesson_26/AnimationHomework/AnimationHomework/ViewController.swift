//
//  ViewController.swift
//  AnimationHomework
//
//  Created by Nickolai Nikishin on 1.02.22.
//

import UIKit

enum AnimationViewPosition {
    case topLeftCorner
    case topRightCorner
    case bottomRightCorner
    case bottomLeftCorner
    case center
}

extension AnimationViewPosition: CaseIterable {
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}

class ViewController: UIViewController {
    var animationPosition: AnimationViewPosition = .center {
        didSet {
            animateToPostion(animationPosition)
        }
    }
    
    var lastRotation: CGFloat = 0

    private let animationView = UIView()
    private static let animationViewDimension: CGFloat = 80
    private var animationViewDimension: CGFloat {
        Self.animationViewDimension
    }
    
    private let isUsingAutolayout = false
    
    private lazy var centerXAnimationViewConstraint: NSLayoutConstraint = {
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    private lazy var centerYAnimationViewConstraint: NSLayoutConstraint = {
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    private lazy var trailingAnimationViewConstraint: NSLayoutConstraint = {
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    }()
    private lazy var leadingAnimationViewConstraint: NSLayoutConstraint = {
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    }()
    private lazy var topAnimationViewConstraint: NSLayoutConstraint = {
        animationView.topAnchor.constraint(equalTo: view.topAnchor)
    }()
    private lazy var bottomAnimationViewConstraint: NSLayoutConstraint = {
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    }()
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        if !isUsingAutolayout {
//            animateToPostion(animationPosition, animated: false)
//        }
    }
    
    // MARK: Setup
    
    private func setup() {
        setupButton()
        setupAnimationView()
    }
    
    private func setupButton() {
        let button = UIButton(type: .custom)
        button.setTitle("Animate", for: .normal)
        button.backgroundColor = .orange
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate(
            [button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)]
        )
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupAnimationView() {
        isUsingAutolayout ? setupAnimationViewUsingAutolayout() : setupAnimationViewUsingFrames()
        setupGesturesInAnimationView()
    }
    
    private func setupAnimationViewUsingFrames() {
        animationView.backgroundColor = .cyan
        animationView.frame = CGRect(x: 0, y: 0, width: animationViewDimension, height: animationViewDimension)
        view.addSubview(animationView)
        animateToPostionUsingFrames(animationPosition, animated: false)
    }
    
    private func setupAnimationViewUsingAutolayout() {
        animationView.backgroundColor = .cyan
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        animationView.heightAnchor.constraint(equalToConstant: animationViewDimension).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: animationViewDimension).isActive = true
        animateToPostionUsingAutolayout(animationPosition, animated: false)
    }
    
    private func setupGesturesInAnimationView() {
        let tapGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureTriggered))
        animationView.addGestureRecognizer(tapGesture)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action:#selector(rotatedView))
        view.addGestureRecognizer(rotateGesture)
        
        let scaleGesture = UIPinchGestureRecognizer(target: self, action:#selector(scaledView))
        view.addGestureRecognizer(scaleGesture)
    }
    
    // MARK: IBActions
    
    @objc func rotatedView(sender: UIRotationGestureRecognizer) {
        var originalRotation: CGFloat = 0
        if sender.state == .began {
            print("sender.rotation: \(sender.rotation)")
            // sender.rotation renews everytime the rotation starts
            // delta value but not absolute value
            sender.rotation = lastRotation
            
            // the last rotation is the relative rotation value when rotation stopped last time,
            // which indicates the current rotation
            originalRotation = sender.rotation
            
        } else if sender.state == .changed {
            
            let newRotation = sender.rotation + originalRotation
            animationView.transform = CGAffineTransform(rotationAngle: newRotation)
            
        } else if sender.state == .ended {
            
            // Save the last rotation
            lastRotation = sender.rotation
            
        }
    }
    
    @objc func scaledView(sender: UIPinchGestureRecognizer) {
        var originalRotation: CGFloat = 0
        if sender.state == .began {
            // sender.rotation renews everytime the rotation starts
            // delta value but not absolute value
            sender.scale = 1
            
            // the last rotation is the relative rotation value when rotation stopped last time,
            // which indicates the current rotation
            originalRotation = sender.scale
            
        } else if sender.state == .changed {

            let newRotation = sender.scale + originalRotation
            print("sender.scale: \(newRotation)")

            animationView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
            
        } else if sender.state == .ended {
            
            // Save the last rotation
            lastRotation = sender.scale
            
        }
    }
    
    @objc func panGestureTriggered(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: self.view)
            print("translation \(translation)")
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(.zero, in: view)
        } else if gestureRecognizer.state == .failed || gestureRecognizer.state == .cancelled || gestureRecognizer.state == .ended {
            animateToPostion(.center, animated: true)
        }
    }
    
    @objc func buttonTapped() {
        animationPosition = animationPosition.next()
    }
    
    // MARK: Functions
    
    private func animateToPostion(_ position: AnimationViewPosition, animated: Bool = true) {
        isUsingAutolayout ? animateToPostionUsingAutolayout(position, animated: animated) : animateToPostionUsingFrames(position, animated: animated)
    }
    
    private func animateToPostionUsingFrames(_ position: AnimationViewPosition, animated: Bool = true) {
        let transformClosure = {
            switch position {
            case .topLeftCorner:
                self.animationView.center = CGPoint(x: self.animationViewDimension / 2, y: self.animationViewDimension / 2)
                self.animationView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4 * 1)
            case .topRightCorner:
                self.animationView.center = CGPoint(x: self.view.frame.width - self.animationViewDimension / 2, y: self.animationViewDimension / 2)
                self.animationView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4 * 2)
            case .bottomRightCorner:
                self.animationView.center = CGPoint(x: self.view.frame.width - self.animationViewDimension / 2, y:  self.view.frame.height - self.animationViewDimension / 2)
                self.animationView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4 * 3)
            case .bottomLeftCorner:
                self.animationView.center = CGPoint(x: self.animationViewDimension / 2, y:  self.view.frame.height - self.animationViewDimension / 2)
                self.animationView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4 * 4)
            case .center:
                self.animationView.center = self.view.center
                self.animationView.transform = .identity
            }
        }
        
        if animated {
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
                transformClosure()
            }
        } else {
            transformClosure()
        }
    }
    
    private func animateToPostionUsingAutolayout(_ position: AnimationViewPosition, animated: Bool = true) {
        let transformClosure = {
            switch position {
            case .topLeftCorner:
                self.centerXAnimationViewConstraint.isActive = false
                self.centerYAnimationViewConstraint.isActive = false
                self.trailingAnimationViewConstraint.isActive = false
                self.bottomAnimationViewConstraint.isActive = false
                self.leadingAnimationViewConstraint.isActive = true
                self.topAnimationViewConstraint.isActive = true
            case .topRightCorner:
                self.centerXAnimationViewConstraint.isActive = false
                self.centerYAnimationViewConstraint.isActive = false
                self.leadingAnimationViewConstraint.isActive = false
                self.bottomAnimationViewConstraint.isActive = false
                self.trailingAnimationViewConstraint.isActive = true
                self.topAnimationViewConstraint.isActive = true
            case .bottomRightCorner:
                self.centerXAnimationViewConstraint.isActive = false
                self.centerYAnimationViewConstraint.isActive = false
                self.leadingAnimationViewConstraint.isActive = false
                self.topAnimationViewConstraint.isActive = false
                self.bottomAnimationViewConstraint.isActive = true
                self.trailingAnimationViewConstraint.isActive = true
            case .bottomLeftCorner:
                self.centerXAnimationViewConstraint.isActive = false
                self.centerYAnimationViewConstraint.isActive = false
                self.trailingAnimationViewConstraint.isActive = false
                self.topAnimationViewConstraint.isActive = false
                self.bottomAnimationViewConstraint.isActive = true
                self.leadingAnimationViewConstraint.isActive = true
            case .center:
                self.trailingAnimationViewConstraint.isActive = false
                self.leadingAnimationViewConstraint.isActive = false
                self.topAnimationViewConstraint.isActive = false
                self.bottomAnimationViewConstraint.isActive = false
                self.centerXAnimationViewConstraint.isActive = true
                self.centerYAnimationViewConstraint.isActive = true
            }
        }
        
        let rotationClosure = {
            switch position {
            case .topLeftCorner:
                self.animationView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4 * 1)
            case .topRightCorner:
                self.animationView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4 * 2)
            case .bottomRightCorner:
                self.animationView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4 * 3)
            case .bottomLeftCorner:
                self.animationView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4 * 4)
            case .center:
                self.animationView.transform = .identity
            }
        }
        
        transformClosure()
        
        if animated {
            UIView.animate(withDuration: 2) {
                rotationClosure()
                self.view.layoutIfNeeded()
            }
        } else {
            rotationClosure()
            view.layoutIfNeeded()
        }
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    
}
