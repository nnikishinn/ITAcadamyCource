//
//  PersistenceProtocol.swift
//  NewsApp
//
//  Created by Nastenka on 5.03.22.
//

import Foundation
protocol PersistenceProtocol {
    func readFavorites() -> [Article]
    func saveFavorites(_ favorites:[Article])
}
