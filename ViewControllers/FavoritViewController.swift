//
//  FavoritViewController.swift
//  parse
//
//  Created by Антон Павлов on 01.05.2023.
//

import UIKit
import AVKit
import AVFoundation

class FavoritViewController: UIViewController {

    var newsData = [Channels]()
    var filteredData = [Channels]()
    
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer: AVPlayer?
    let movieUrl: NSURL? = NSURL(string: "http://techslides.com/demos/sample-videos/small.mp4")
    
    @IBOutlet weak var favoritSearchBar: UISearchBar!
    @IBOutlet weak var favoritTableView: UITableView!
    @IBOutlet weak var favoritBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startVideo()
        parsingJson { data in
            self.newsData = data
            
            DispatchQueue.main.async {
                self.favoritTableView.reloadData()
            }
        }
    }
    
    func startVideo() {
        if let url = movieUrl {
            self.avPlayer = AVPlayer(url: url as URL)
            self.avPlayerViewController.player = self.avPlayer
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(self.avPlayerViewController, animated: true) {
            self.avPlayerViewController.player?.play()
        }
    }
    
}

// MARK: - НАСТРОЙКА ТАБЛИЦЫ - Чтобы все работало нормально но без search поставить везде newsData

extension FavoritViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritCell") as? FavoritTableViewCell else { return FavoritTableViewCell() }
        
        cell.favoritTitle.text = filteredData[indexPath.row].name_ru
        cell.favoritDescription.text = filteredData[indexPath.row].current.title
        
        if let imageURL = URL(string: filteredData[indexPath.row].image) {
            
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
    
    
    
}

// MARK: - НАСТРОЙКИ SEARCH BAR

extension FavoritViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredData = newsData.filter({$0.name_ru.contains(searchText)})
            favoritTableView.reloadData()
        } else {
            self.filteredData = newsData
            favoritTableView.reloadData()
        }
    }
}
