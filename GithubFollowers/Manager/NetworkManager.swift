//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 16/05/21.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/"
    private init() {}
    
    func getFollowers(for username: String,page: Int,completion: @escaping ([Follower]?,ErrorMessages?) -> Void) {
        let endpoint = baseUrl + "users/\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(nil,ErrorMessages.invaildRequest)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(nil,.noInternet)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, .invaildResponse)
                return
            }
            guard let data = data else {
                completion(nil,.noData)
                return
            }
            do {
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                DispatchQueue.main.async {
                    completion(followers,nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil,.noData)
                }
            }
        }
        task.resume()
    }
}
