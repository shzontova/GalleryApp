//
//  DatabaseManager.swift
//  GalleryApp
//
//  Created by Sasha Zontova on 3.02.24.
//

import Foundation

final class DatabaseManager {
    
    private static let favoritesKey = "favoritePhotos"
    
    static func isFavorite(photo: Photo) -> Bool {
        let favorites = getFavorites()
        return favorites.contains(photo.id)
    }

    static func toggleFavorite(photo: Photo) {
        var favorites = getFavorites()

        if let index = favorites.firstIndex(of: photo.id) {
            favorites.remove(at: index)
        } else {
            favorites.append(photo.id)
        }

        saveFavorites(favorites)
    }

    private static func getFavorites() -> [String] {
        if let favorites = UserDefaults.standard.array(forKey: favoritesKey) as? [String] {
            return favorites
        }
        return []
    }

    private static func saveFavorites(_ favorites: [String]) {
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }
}
