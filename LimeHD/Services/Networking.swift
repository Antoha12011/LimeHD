//
//  Networking.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import Foundation
import UIKit

final class NetworkService {
    
    /// Получение каналов
    func fetchChannels(url: URL, completion: @escaping (Result<[Channel], Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = "GET"
        session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                guard let data else { return }
                let decodeData = try JSONDecoder().decode(LimeResponse.self, from: data)
                completion(.success(decodeData.channels))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    /// Получение изображений
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = "GET"
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Invalid HTTP response")
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
                
            } else {
                completion(nil)
            }
        }.resume()
    }
}
