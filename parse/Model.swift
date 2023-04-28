//
//  Model.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import Foundation

struct NewsFeed: Decodable {
    var channels: [Channels]
}

struct Channels: Decodable {
    var name_ru: String
    var image: String
}
