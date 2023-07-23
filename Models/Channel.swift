//
//  Channel.swift
//  parse
//
//  Created by Антон Павлов on 23.07.2023.
//

import Foundation

struct Channel: Decodable {
    let channels: [ChannelData]?
}

struct ChannelData: Decodable {
    let name: String?
    let url: String?
    let image: String?
    let current: CurrentBroadcast?
}

struct CurrentBroadcast: Decodable {
    let title: String?
}

extension ChannelData {
    private enum CodingKeys: String, CodingKey {
        case name = "name_ru"
        case url = "url"
        case image = "image"
        case current = "current"
    }
}
