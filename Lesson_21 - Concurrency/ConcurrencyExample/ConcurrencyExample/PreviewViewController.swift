//
//  PreviewViewController.swift
//  ConcurrencyExample
//
//  Created by Nickolai Nikishin on 15.01.22.
//

import UIKit

class PreviewViewController: UIViewController {
    public var image1: UIImage?
    public var image2: UIImage?
    public var image3: UIImage?

    
    @IBOutlet private weak var imageView1: UIImageView!
    @IBOutlet private weak var imageView2: UIImageView!
    
    @IBOutlet private weak var imageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView1.image = image1
        imageView2.image = image2
        imageView3.image = image3
    }
}
