//
//  FavoritViewController.swift
//  parse
//
//  Created by Антон Павлов on 01.05.2023.
//

import UIKit

class FavoritViewController: UIViewController {
    
    // MARK: - Properties
    private var channels = [Channels]()
    private var filteredChannels = [Channels]()
    
    // MARK: - Cell Identifier
    private let cellIdentifier = "favoritCell"
    
    // MARK: - Outlets
    @IBOutlet weak var favoritSearchBar: UISearchBar!
    @IBOutlet weak var favoritTableView: UITableView!
    @IBOutlet weak var favoritBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        parsingJson { data in
            self.channels = data
            DispatchQueue.main.async {
                self.favoritTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate / UITableViewDataSource
extension FavoritViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredChannels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FavoritTableViewCell else { return FavoritTableViewCell() }
        
        cell.favoritTitle.text = filteredChannels[indexPath.row].name_ru
        cell.favoritDescription.text = filteredChannels[indexPath.row].current.title
        
        if let imageURL = URL(string: filteredChannels[indexPath.row].image) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.favoritImage.image = image
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
           startVideo()
        }
    }
    
}

// MARK: - НАСТРОЙКИ SEARCH BAR
extension FavoritViewController: UISearchBarDelegate {
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
        favoritTableView.reloadData()
    }
}


