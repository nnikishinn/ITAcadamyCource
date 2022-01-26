//
//  ViewController.swift
//  RandomCatApp
//
//  Created by Александр Савков on 21.01.22.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel: ViewModel = ViewModel()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let presentPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("ПОКАЗАТЬ КОТА", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.backgroundColor = .init(red: 0, green: 255/250, blue: 204/250, alpha: 220)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstrains()
        presentPhotoButton.addTarget(self, action: #selector(presentPhotoButtonTupped), for: .touchUpInside)
        
        bindModel()
        
        

    }
    
   
    
    func bindModel() {
        viewModel.loadImagesCompletion = { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateUI(isLoading: false)
                switch result {
                case .success(let image):
                   self.imageView.image = image
                case .failure(let error):
                   self.showError(with: error)
                }
            }
        }
    }
    
    func showCat() {
        loadImages()
    }
    
    @objc func presentPhotoButtonTupped() {
        imageView.image = nil
        showCat()
    }
    
    func loadImages()  {
        updateUI(isLoading: true)
        viewModel.loadImages()
    }
    
    func updateUI(isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        presentPhotoButton.isEnabled = !isLoading
    }
    
    func showError(with error: Error) {
        let myAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        myAlert.addAction(okeyAction)
        self.present(myAlert, animated: true, completion: nil)
    }
}

extension ViewController {
    func setConstrains() {

        view.backgroundColor = .white
        title = "Случайный кот"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
        
        view.addSubview(presentPhotoButton)
        NSLayoutConstraint.activate([
            presentPhotoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            presentPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentPhotoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            presentPhotoButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}
