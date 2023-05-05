//
//  FavoritViewController.swift
//  parse
//
//  Created by Антон Павлов on 01.05.2023.
//

import UIKit

final class FavoritViewController: UIViewController {
    
    // MARK: - Properties
    
    private var channels = [Channels]()
    
    
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
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FavoritTableViewCell else { return FavoritTableViewCell() }
        
        cell.favoritTitle.text = channels[indexPath.row].name_ru
        cell.favoritDescription.text = channels[indexPath.row].current.title
        
        if let imageURL = URL(string: channels[indexPath.row].image) {
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



