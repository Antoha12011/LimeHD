//
//  ViewController.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // ТУТ 100% СТАВИТСЯ ВТОРАЯ КОЛОНКА ИЗ КЛАССА NewsFeed
    var newsData = [Channels]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parsingJson { data in
            self.newsData = data

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func parsingJson(completion: @escaping ([Channels]) -> ()) {
        
        let urlString = "https://limehd.online/playlist/channels.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else { return }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
                
                do {
                    let ParsingData = try decoder.decode(NewsFeed.self, from: data!)
                    completion(ParsingData.channels)
                } catch {
                    print("Error")
                }
            }
        }
        dataTask.resume()
        
    }
}

    struct NewsFeed: Decodable {
        var channels: [Channels]
    }

    struct Channels: Decodable {
        var name_ru: String
        var image: String
    }
    





// MARK: - UITableViewDelegate / UITableViewDataSource


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = newsData[indexPath.row].name_ru
        
        return cell
    }
    
}

