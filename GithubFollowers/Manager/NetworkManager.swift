//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 16/05/21.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username: String,page: Int,completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseUrl + "users/\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invaildRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invaildResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                completion(.success(followers))
            }
            catch {
                    completion(.failure(.noData))
            }
        }
        task.resume()
    }
}
