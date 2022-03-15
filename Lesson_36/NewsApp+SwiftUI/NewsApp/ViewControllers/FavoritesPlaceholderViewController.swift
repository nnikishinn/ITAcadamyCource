//
//  FavoritesPlaceholderViewController.swift
//  NewsApp
//
//  Created by Nickolai Nikishin on 12.03.22.
//

import UIKit
import SwiftUI

class FavoritesPlaceholderViewController: UIViewController {
    private let articleManager: PersistenceProtocol = UserDefaultsManager()
    private let articlesViewModel = ArticlesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = UIHostingController(rootView: FavoritesSwiftUIView(viewModel: articlesViewModel))
        let subview = vc.view
        subview?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vc.view)
        subview?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        subview?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        subview?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        subview?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        addChild(vc)
        vc.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        articlesViewModel.articles =  articleManager.readFavorites()
    }
}
