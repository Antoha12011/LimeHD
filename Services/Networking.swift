//
//  Networking.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import Foundation
import UIKit

//MARK: NetworkManagerProtocol

protocol NetworkManagerProtocol {
    func fetchListOfChannels(completion: @escaping (Channel?) -> Void)
    func fetchImage(from url: String, completion: @escaping (Data?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    func fetchListOfChannels(completion: @escaping (Channel?) -> Void) {
        
        let urlString = "http://limehd.online/playlist/channels.json"
        performRequest(withURLString: urlString) { data, error in
            if let error = error {
                print("Error recieved requesting text data: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: Channel.self, from: data)
            completion(decode)
        }
    }
    
    func fetchImage(from url: String, completion: @escaping (Data?) -> Void) {
        performRequest(withURLString: url) { data, error in
            if let error = error {
                print("Error recieved requesting image data: \(error.localizedDescription)")
                completion(nil)
            }
            completion(data)
        }
    }
    
    private func performRequest(withURLString urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}

 
