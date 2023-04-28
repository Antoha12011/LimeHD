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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

