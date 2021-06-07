//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Jagdeep Singh on 07/06/21.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completion: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrivedFavorties = favorites
                
                switch actionType {
                case .add:
                    guard !retrivedFavorties.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    retrivedFavorties.append(favorite)

                case .remove:
                    retrivedFavorties.removeAll { user in
                        user.login == favorite.login
                        
                    }
                }
                
                completion(save(favorites: favorites))
                
            case .failure(let error):
                completion(error)
            }
        }
        
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower],GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let favorites = try JSONDecoder().decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        }
        catch {
                completion(.failure(.unableToFavorites))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        
        do {
            let encodedFavorites = try JSONEncoder().encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
        } catch {
            return .unableToSave
        }
        
        return nil
    }
    
}
