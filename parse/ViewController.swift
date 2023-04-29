//
//  ViewController.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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

    
    
}






// MARK: - НАСТРОЙКА ТАБЛИЦЫ

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else { return UITableViewCell() }
        
        cell.myLabel.text = newsData[indexPath.row].name_ru
        
        if let imageURL = URL(string: newsData[indexPath.row].image) {
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.myImage.image = image
                    }
                }
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
    
   
    


