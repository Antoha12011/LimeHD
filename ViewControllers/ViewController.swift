//
//  ViewController.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    var newsData = [Channels]()
    var filteredData = [Channels]()

    let avPlayerViewController = AVPlayerViewController()
    var avPlayer: AVPlayer?
    let movieUrl: NSURL? = NSURL(string: "http://techslides.com/demos/sample-videos/small.mp4")
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var allChannelsBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startVideo()
        parsingJson { data in
            self.newsData = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else { return UITableViewCell() }
        
        cell.myLabel.text = filteredData[indexPath.row].name_ru
        cell.discriptionLbl.text = filteredData[indexPath.row].current.title
        
        if let imageURL = URL(string: filteredData[indexPath.row].image) {
            
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

// MARK: - НАСТРОЙКИ SEARCH BAR

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredData = newsData.filter({$0.name_ru.contains(searchText)})
            tableView.reloadData()
        } else {
            self.filteredData = newsData
            tableView.reloadData()
        }
    }
}


// MARK: - НАСТРОЙКИ SEARCH BAR, ЧТОБЫ ВСЕ ОТОБРАЖАЛОСЬ КАК РАНЬШЕ УДАЛИТЬ ЭТУ ЧАСТЬ

//extension ViewController: UISearchBarDelegate {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        filteredData = []
//
//        if searchText == "" {
//            filteredData = newsData
//        } else {
//            for item in newsData {
//                if item.name_ru.lowercased().contains(searchText.lowercased()) {
//                    filteredData.append(item)
//                }
//            }
//        }
//        self.tableView.reloadData()
//    }
//
//}
    




