//
//  NewsFeed.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import Foundation


struct NewsFeed: Codable {
    // ТО ЕСТЬ МНЕ ТУТ НУЖНО УКАЗАТЬ CHANNELS, ОН СТОИТ В САМОМ ВВЕРХУ В JSON
    var channels: [Channels]?
}

// ТУТ НУЖНО УКАЗАТЬ ВСЕ ДАННЫЕ КОТОРЫЕ ХОЧУ ПОЛУЧАТЬ ИЗ JSON
struct Channels: Codable {
    
    var name_ru: String
    var image: String
   // var title: String? - В ДАННЫЙ МОМЕНТ title НЕ ПОЛУЧАЕТ
}
