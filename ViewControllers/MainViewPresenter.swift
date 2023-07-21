//
//  FavoritViewController.swift
//  parse
//
//  Created by Антон Павлов on 01.05.2023.
//

import Foundation

//MARK: MainViewPresenterProtocol
protocol MainViewPresenterProtocol {
    init(view: MainViewProtocol, networkManager: NetworkManagerProtocol)
    func fetchChannels()
    func fetchImage(from url: String)
    var imageData: Data? { get set }
    var channels: [ChannelData]? { get set }
}

class MainViewPresenter: MainViewPresenterProtocol {
    unowned let view: MainViewProtocol
    let networkManager: NetworkManagerProtocol!
    var imageData: Data?
    var channels: [ChannelData]?

    required init(view: MainViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
        fetchChannels()
    }
    
    func fetchChannels() {
        networkManager.fetchListOfChannels { [weak self] channels in
            guard let self = self else { return }
            self.channels = channels?.channels
            self.view.reloadData()
        }
    }
    
    func fetchImage(from url: String) {
        networkManager.fetchImage(from: url) { [weak self] imageData in
            guard let self = self else { return }
            self.imageData = imageData
        }
    }
}
