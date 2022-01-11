//
//  DataSource.swift
//  StudentList
//
//  Created by Nickolai Nikishin on 28.11.21.
//

import Foundation
import UIKit

struct StudentGitObject: Codable {
    let name: String?
    let avatar_url: String
    let login: String
}

struct StudentObject {
    let name: String
    let login: String
}


struct DataSource {
    static let menArray =
    [
        StudentObject(name: "Артимович Игорь Владимирович", login: "artsimovich"),
        StudentObject(name: "Букаренко Арина Олеговна", login: "arinabukarenko"),
        StudentObject(name: "Гришин Павел Андреевич", login: "PavelGrishiin"),
        StudentObject(name: "Ефименко Анастасия Владимировна", login: "Anastasia537"),
        StudentObject(name: "Симонов Владислав Дмитриевич", login: "Vladie330"),
    ]
    
    static func fetchGithubUser(_ userName: String, completionHandler: @escaping (Result<StudentGitObject, Error>) -> Void) {
        
        print("started task fetch github user \(userName)")

        let url = URL(string: "https://api.github.com/users/\(userName)")
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("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", forHTTPHeaderField: "access_token")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    print("completed task fetch github user \(userName)")
                    let githubUser = try decoder.decode(StudentGitObject.self, from: data)
                    completionHandler(.success(githubUser))

                } catch {
                    completionHandler(.failure(error))
                    print("error parsing \(try? JSONSerialization.jsonObject(with: data, options:[]))")
                }
            }
        }
        
        dataTask.resume()
    }
    
    static func fetchAvatar(url: URL, completionHandler: @escaping (Result<UIImage?, Error>) -> Void) {
        print("started task fetch avatar url \(url)")

        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            if let data = try? Data(contentsOf: url) {
                print("completed task fetch avatar url \(url)")
                completionHandler(.success(UIImage(data: data)))
            }
        }
        
        dataTask.resume()
    }
    
    static func fetchGithubUserAvatar(_ userName: String, completionHandler: @escaping (Result<UIImage?, Error>) -> Void) {
        print("started task fetch user \(userName)")

        fetchGithubUser(userName) { result in
            switch result {
            case .success(let githubUser):
                let url = URL(string: githubUser.avatar_url)!
                fetchAvatar(url: url) { result in
                    completionHandler(result)
                    print("completed task fetch user \(userName)")
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
