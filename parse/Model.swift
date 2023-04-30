//
//  Model.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import Foundation

 struct NewsFeed: Decodable {
     let channels: [Channels]
}

 struct Channels: Decodable {
     let name_ru: String
     let image: String
     let current: CurrentChannels
}

struct CurrentChannels: Decodable {
    let title: String
}


