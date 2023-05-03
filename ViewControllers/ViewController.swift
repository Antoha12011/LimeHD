//
//  ViewController.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    var channels = [Channels]()
    var filteredChannels = [Channels]()
    
    // MARK: - Cell Identifier
    let cellIdentifier = "cell"
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var allChannelsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeColorTextField()
        startVideo()
        parsingJson { data in
            self.channels = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Смена цвета текста в search bar
    func changeColorTextField() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
    }
}

// MARK: - UITableViewDelegate / UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredChannels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableViewCell else { return UITableViewCell() }
        
        cell.myLabel.text = filteredChannels[indexPath.row].name_ru
        cell.discriptionLbl.text = filteredChannels[indexPath.row].current.title
        
        if let imageURL = URL(string: filteredChannels[indexPath.row].image) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(avPlayerViewController, animated: true) {
            avPlayerViewController.player?.play()
        }
    }
    
}

// MARK: - НАСТРОЙКИ SEARCH BAR
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredChannels = []
        
        if searchText == "" {
            filteredChannels = channels
        } else {
            for item in channels {
                if item.name_ru.lowercased().contains(searchText.lowercased()) {
                    filteredChannels.append(item)
                }
            }
        }
        tableView.reloadData()
    }
}





