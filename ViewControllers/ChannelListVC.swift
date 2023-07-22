//
//  ViewController.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func reloadData()
}

final class ChannelListVC: UIViewController {
    
    // MARK: - Properties
    
    private var presenter: MainViewPresenterProtocol!
    private var isFirstSegmentSelected = true

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var allChannels: UIButton!
    @IBOutlet weak var favoritBtn: UIButton!
    @IBOutlet weak var lineUnderBtn: UIView!
    @IBOutlet weak var lineUnderFavoritBtn: UIView!
    
    @IBAction func allChannelsBtn(_ sender: Any) {
        lineUnderBtn.isHidden = false
        lineUnderFavoritBtn.isHidden = true
        tableView.reloadData()
    }
    
    @IBAction func favoritChannelsBtn(_ sender: Any) {
        lineUnderFavoritBtn.isHidden = false
        lineUnderBtn.isHidden = true
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineUnderBtn.isHidden = false
        lineUnderFavoritBtn.isHidden = true
        
        changeColorTextField()
        
        let networkManager = NetworkManager()
        presenter = MainViewPresenter(view: self, networkManager: networkManager)
    }
    // MARK: - Смена цвета текста в search bar
    
    private func changeColorTextField() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
    }
}

// MARK: - UITableViewDelegate / UITableViewDataSource

extension ChannelListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isFirstSegmentSelected {
        case true:
            return presenter.channels?.count ?? 0
        case false:
            return StorageManager.shared.realm.objects(FavoriteChannel.self).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var isFavoriteStatus: Bool = false
        let networkObject = presenter.channels?[indexPath.row].name
        let dataObject = StorageManager.shared.realm.objects(FavoriteChannel.self).filter("name = %@", networkObject ?? "")
        if dataObject.isEmpty {
            isFavoriteStatus = false
        } else {
            isFavoriteStatus = true
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
    
        switch isFirstSegmentSelected {
        case true:
            cell.configure(
                with: presenter.channels?[indexPath.row].name ?? "",
                channelTitle: presenter.channels?[indexPath.row].current?.title ?? "",
                image: presenter.channels?[indexPath.row].image ?? "",
                isStarButtonActive: isFavoriteStatus
            )
        case false:
            let favoriteChannels = StorageManager.shared.realm.objects(FavoriteChannel.self)
            cell.configure(
                with: favoriteChannels[indexPath.row].name,
                channelTitle: favoriteChannels[indexPath.row].title,
                image: favoriteChannels[indexPath.row].image,
                isStarButtonActive: true
            )
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

//MARK: - MainViewProtocol
extension ChannelListVC: MainViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}

//MARK: - Keyboard Settings
extension ChannelListVC: UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: - НАСТРОЙКИ SEARCH BAR

//extension ViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        filteredChannels = []
//
//        if searchText == "" {
//            filteredChannels = channels
//        } else {
//            for item in channels {
//                if item.name_ru.lowercased().contains(searchText.lowercased()) {
//                    filteredChannels.append(item)
//                }
//            }
//        }
//        tableView.reloadData()
//    }
//}





