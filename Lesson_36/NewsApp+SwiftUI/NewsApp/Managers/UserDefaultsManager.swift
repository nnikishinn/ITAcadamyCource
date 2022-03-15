//
//  UserDefaultsManager.swift
//  NewsApp
//
//  Created by Nastenka on 5.03.22.
//

import Foundation
class UserDefaultsManager: PersistenceProtocol {
    let userDefaults = UserDefaults.standard
    
    func readFavorites() -> [Article] {
        if let decoded = userDefaults.object(forKey: "encoded") as? Data {
            let decoder = JSONDecoder()
            if let favorites = try? decoder.decode(Favorites.self, from: decoded) { return favorites.articles
            }
        }
        return []
    }
    
    func saveFavorites(_ favorites: [Article]) {
        let encoder = JSONEncoder()
        let favorite = Favorites(articles: favorites)
        if let encoded = try? encoder.encode(favorite) {
            userDefaults.set(encoded, forKey: "encoded")
        }
    }
}
