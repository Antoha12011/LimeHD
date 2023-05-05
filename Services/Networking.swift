//
//  Networking.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import Foundation

func parsingJson(completion: @escaping ([Channels]) -> ()) {
    
    let urlString = "https://limehd.online/playlist/channels.json"
    
    let url = URL(string: urlString)
    
    guard url != nil else { return }
    
    let session = URLSession.shared
    let _ = session.dataTask(with: url!) { data, response, error in
        
        guard error == nil && data != nil else { return }
        
        let decoder = JSONDecoder()
        do {
            let ParsingData = try decoder.decode(JsonData.self, from: data!)
            completion(ParsingData.channels)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
    }.resume()
}
