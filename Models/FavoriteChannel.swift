//
//  FavoriteChannel.swift
//  parse
//
//  Created by Антон Павлов on 23.07.2023.
//

import Foundation
import RealmSwift

class FavoriteChannel: Object {
    @Persisted dynamic var name = ""
    @Persisted dynamic var url = ""
    @Persisted dynamic var image = ""
    @Persisted dynamic var title = ""
}
