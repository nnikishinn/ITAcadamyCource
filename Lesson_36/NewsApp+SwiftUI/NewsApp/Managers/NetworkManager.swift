//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Nastenka on 23.02.22.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    func getArticles(from date: Date, completion: @escaping (Swift.Result<[Article],Error>) -> ()) {
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let todayDateString = dateFormatter.string(from: date)
       
        let urlString = "https://newsapi.org/v2/everything?q=apple&from=\(todayDateString)&to=\(todayDateString)&sortBy=popularity&apiKey=111eea412bb9431f960d4e19897b9d06"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error ) in
            if let error = error {
                completion(.failure(error))
                print (error)
                return
            }
            guard let data = data else {return}
            do {
        
                let results = try JSONDecoder().decode(Result.self, from: data)
                completion(.success(results.articles))
                print(results.articles)
            }
            catch {
                completion(.failure(error))
                print (error)
            }
        }
        .resume()
    }
}
