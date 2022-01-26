//
//  ViewModel.swift
//  RandomCatApp
//
//  Created by Nickolai Nikishin on 25.01.22.
//

import UIKit

class ViewModel {
    private var networksManager: NetworkManagerProtocol?
    public var loadImagesCompletion: ((Result<UIImage?, Error>) -> Void)?
    
    init() {
        self.networksManager = NetworkManager()
    }
    
    func loadImages() {
        networksManager?.loadImages { [weak self] result in
           self?.loadImagesCompletion?(result)
        }
    }
}
