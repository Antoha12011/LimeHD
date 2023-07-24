//
//  StorageManager.swift
//  parse
//
//  Created by Антон Павлов on 23.07.2023.
//

import Foundation

protocol Storage {
    var favoritesId: [Int] { get }
    func add(_ id: Int)
    func save(_ favoritesId: [Int], userDefaultsKey: String)
    func load()
}

final class StorageService: Storage {
    
    static let shared = StorageService()
    static let userDefaultsFavoriteKey = "favoritesKeys"
    
    var favoritesId = [Int]() {
        didSet {
            save(favoritesId, userDefaultsKey: StorageService.userDefaultsFavoriteKey)
        }
    }
    
    public func add(_ id: Int) {
        favoritesId.append(id)
    }
    
    public func delete(_ id: Int) {
        favoritesId.removeAll { $0 == id }
    }
    
    func save(_ favoritesId: [Int], userDefaultsKey: String) {
        UserDefaults.standard.set(favoritesId, forKey: userDefaultsKey)
    }
    
    func load() {
        favoritesId = UserDefaults.standard.array(forKey: StorageService.userDefaultsFavoriteKey) as? [Int] ?? []
    }
    private init() {}
}
