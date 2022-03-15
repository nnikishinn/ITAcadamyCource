//
//  ViewController.swift
//  NewsApp
//
//  Created by Nastenka on 22.02.22.
//

import UIKit
import Kingfisher

final class NewsViewController: UIViewController {
    let articleManager: PersistenceProtocol = UserDefaultsManager()
    lazy var favArticles: [Article] = {
    articleManager.readFavorites()
    }()
    let refreshControl = UIRefreshControl()
    static let maxDays = 7
    var dayOffset = 0
    var currentDate = Date()
    var isLoading = false
    var articles:[Article] = []
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.dataSource = self
        newsTableView.delegate = self
        getArticles()
        setupRefreshControl()
    }
    
    private func setupRefreshControl() {
        newsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        getArticles(fromRefreshControl: true)
    }
    
    private func getArticles(fromRefreshControl: Bool = false) {
        if isLoading {
            return
        }
        
        if dayOffset >= Self.maxDays {
            showOffsetMaxLimit()
            return
        }
        
        if fromRefreshControl {
            dayOffset = 0
        }
        
        guard let nextDate = Calendar.current.date(byAdding: .day, value: -dayOffset, to: currentDate) else {
            return
        }
        isLoading = true
        NetworkManager.shared.getArticles(from: nextDate) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    if fromRefreshControl{
                        self.articles = articles
                        self.refreshControl.endRefreshing()
                    } else {
                        self.articles.append(contentsOf: articles)
                    }
                    self.newsTableView.reloadData()
                    self.dayOffset += 1
                case .failure(let error):
                    self.showError(error)
                }
                self.isLoading = false
            }
        }
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showOffsetMaxLimit() {
        let alert = UIAlertController(title: "Warning", message: "You reached max limit of displayed news days", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else { return UITableViewCell() }
        let article = articles[indexPath.row]
        cell.newsTitleLabel.text = article.title
        cell.newsDescriptionLabel.text = article.description
        cell.favButton.isSelected = Set(favArticles).contains(article)
        cell.onFavButtonTapped = { [weak self] in
            guard let self = self else { return }
            if cell.favButton.isSelected {
                self.favArticles.append(article)
            } else {
                if let index = self.favArticles.firstIndex(of: article) {
                    self.favArticles.remove(at: index)
                }
            }
            self.articleManager.saveFavorites(self.favArticles)
        }
        
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

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == articles.count - 1 {
            getArticles()
        }
    }
}


