//
//  ViewController.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJson()
    }
    
    
    
    
    // MARK: - Networking
    
    func getJson() {
        
        let urlString = "https://limehd.online/playlist/channels.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else { return }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
                
                do {
                    
                    let newsFeed = try decoder.decode(NewsFeed.self, from: data!)
        
                    print(newsFeed)
                }
                catch {
                    print("Error")
                }
            }
        }
        dataTask.resume()
    }
    
}
