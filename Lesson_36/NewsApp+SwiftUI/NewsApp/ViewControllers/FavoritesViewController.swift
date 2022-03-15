//
//  FavoritesViewController.swift
//  NewsApp
//
//  Created by Nastenka on 22.02.22.
//

import UIKit
import Kingfisher

final class FavoritesViewController: UIViewController {
    let articleManager: PersistenceProtocol = UserDefaultsManager()
    lazy var articles:[Article] = {
    articleManager.readFavorites()
    }()
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        articles =  articleManager.readFavorites()
        favoritesTableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else { return UITableViewCell() }
        let article = articles[indexPath.row]
        cell.newsTitleLabel.text = article.title
        cell.newsDescriptionLabel.text = article.description
        
        let placeholderImage = UIImage(named: "placeholder")
        let processor = DownsamplingImageProcessor(size: cell.newsImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        cell.newsImageView.kf.indicatorType = .activity
        if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
            cell.newsImageView.kf.setImage(
                with: url,
                placeholder: placeholderImage,
                options: [
                    .processor(processor),
                    .loadDiskFileSynchronously,
                    .cacheOriginalImage,
                    .transition(.fade(0.25)),
                ],
                progressBlock: { receivedSize, totalSize in
                },
                completionHandler: { result in
                }
            )
        } else {
            cell.newsImageView.image = placeholderImage
        }
        return cell
    }
}


