//
//  NetworksManager.swift
//  RandomCatApp
//
//  Created by Александр Савков on 21.01.22.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case loadingError
    case unspecifiedError
}

extension NetworkError: LocalizedError {
    public var localizedDescription: String? {
        switch self {
        case .loadingError:
            return NSLocalizedString("Error loading image. Please try again later", comment: "")
        case .unspecifiedError:
            return NSLocalizedString("Unknown error arised. Please try again later", comment: "")
        }
    }
}

protocol NetworkManagerProtocol {
    func loadImages(completion: @escaping (Result<UIImage?, Error>) -> Void)
}

struct NetworkManagerTest: NetworkManagerProtocol {
    func loadImages(completion: @escaping (Result<UIImage?, Error>) -> Void) {
        completion(.success(UIImage(named: "1.jpg")))
    }
    
    
}

struct NetworkManager: NetworkManagerProtocol {
    
    let headers = ["x-api-key": "9cccab3a-0151-4ef9-a53c-a506e40636aa"]
    let urlPhotos = "https://api.thecatapi.com/v1/images/search"
    
    func loadImages(completion: @escaping (Result<UIImage?, Error>) -> Void) {
       
        let request = NSMutableURLRequest(url: NSURL(string:  urlPhotos)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(NetworkError.unspecifiedError))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unspecifiedError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let imageURL = try decoder.decode([Photos].self, from: data)
                guard let url = URL(string: imageURL[0].url!) else {return}
               
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                completion(.success(image))
            } catch {
                completion(.failure(NetworkError.unspecifiedError))
            }
        }.resume()
    }
}
