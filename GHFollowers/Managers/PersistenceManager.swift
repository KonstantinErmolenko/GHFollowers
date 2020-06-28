//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 28.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {

    static private let defaults = UserDefaults.standard
    
    enum Keys { static let favorites = "favorites" }

    static func updateFavorites(with user: Follower, action: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch action {
                case .add:
                    guard !retrievedFavorites.contains(user) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrievedFavorites.append(user)
                    
                case .remove:
                    retrievedFavorites.removeAll { $0.login == user.login }
                }
                
                completed(saveFavorites(favorites: retrievedFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func saveFavorites(favorites: [Follower]) -> GFError? {
        do {
            let encoder          = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
