//
//  StorageManager.swift
//  parse
//
//  Created by Антон Павлов on 23.07.2023.
//

import Foundation
import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    func save(favoriteChannel: FavoriteChannel) {
        write {
            realm.add(favoriteChannel)
        }
    }
    
    func delete(favoriteChannel: FavoriteChannel) {
        write {
            let object = realm.objects(FavoriteChannel.self).filter("name = %@", favoriteChannel.name)
            realm.delete(object)
        }
    }
    
    
    private func write(_ completion: () -> Void) {
        do {
            try realm.write { completion() }
        } catch let error {
            print(error)
        }
    }
}
