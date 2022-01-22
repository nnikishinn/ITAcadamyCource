//
//  ViewController.swift
//  ConcurrencyExample
//
//  Created by Nickolai Nikishin on 15.01.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        activityIndicator.startAnimating()
        let queue = DispatchQueue(label: "com.myapp.download-images", qos: .utility, attributes: .concurrent)
        
        let urlStr1 = "https://effigis.com/wp-content/uploads/2015/02/DigitalGlobe_WorldView2_50cm_8bit_Pansharpened_RGB_DRA_Rome_Italy_2009DEC10_8bits_sub_r_1.jpg"
        let url1 = URL(string: urlStr1)!
        
        
        let urlStr2 = "https://upload.wikimedia.org/wikipedia/commons/b/b2/JPEG_compression_Example.jpg"
        
        let urlStr3 = "https://onlinejpgtools.com/images/examples-onlinejpgtools/sunflower.jpg"
        
        let url2 = URL(string: urlStr2)!
        let url3 = URL(string: urlStr3)!
        
        print("Start")
        
        let dispatchGroup = DispatchGroup()
        var image1: UIImage?
        var image2: UIImage?
        var image3: UIImage?
        
        dispatchGroup.enter()
        queue.async {
            print("Start downloading image 1")
            if let data = try? Data(contentsOf: url1) {
                image1 = UIImage(data: data)
            }
            dispatchGroup.leave()
            print("Finish downloading image 1")
            
        }
        
        dispatchGroup.enter()
        queue.async {
            print("Start downloading image 2")
            
            if let data = try? Data(contentsOf: url2) {
                image2 = UIImage(data: data)
            }
            dispatchGroup.leave()
            
            print("Finish downloading image 2")
            
        }
        
        dispatchGroup.enter()
        queue.async {
            print("Start downloading image 3")
            
            if let data = try? Data(contentsOf: url3) {
                image3 = UIImage(data: data)
            }
            print("Finish downloading image 3")
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Dispatch group notify")
            self.present(image1: image1, image2: image2, image3: image3)
        }
        
        print("Done")
    }
    
    func present(image1: UIImage?, image2: UIImage?, image3: UIImage?) {
        
        
        guard let image1 = image1 else {
            print("Image 1 is missing")
            return
        }
        
        guard let image2 = image2 else {
            print("Image 2 is missing")
            return
        }
        
        guard let image3 = image3 else {
            print("Image 3 is missing")
            return
        }
        
        DispatchQueue.main.async {
            let previewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
            previewVC.image1 = image1
            previewVC.image2 = image2
            previewVC.image3 = image3
            
            self.present(previewVC, animated: true, completion: nil)
            
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    deinit {
        print("controller is deinited")
    }
}

