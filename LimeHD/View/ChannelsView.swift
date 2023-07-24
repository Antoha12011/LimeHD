//
//  ChannelsView.swift
//  LimeHD
//
//  Created by Антон Павлов on 24.07.2023.
//

import Foundation
import UIKit

protocol ChannelsViewDelegate: AnyObject {
    func reloadView(_ favorites: [Channel], fromFavorites: Bool)
    func pushVideoPlayer(_ url: URL)
}

final class ChannelsView: UIView {
    
    // MARK: - Public Properties
    
    weak var delegate: ChannelsViewDelegate?
    var isFavorite: Bool
    lazy var favoriteChanels = channels.filter { storageService.favoritesId.contains($0.id) } {
        didSet {
            if isFavorite { hideCollection() }
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 0.14, green: 0.14, blue: 0.15, alpha: 1)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ChannelCell.self, forCellWithReuseIdentifier: ChannelCell.cellId)
        cv.dataSource = self
        cv.delegate = self
        cv.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        return cv
    }()
    
    // MARK: - Private Properties
    
    private let storageService = StorageService.shared
    private let networkService = NetworkService()
    private var channels: [Channel]
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет избранных каналов"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Override
    
    override init(frame: CGRect) {
        self.channels = []
        self.isFavorite = false
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.14, green: 0.14, blue: 0.15, alpha: 1)
        setupViews()
        setupConstarints()
    }
    
    convenience init(channels: [Channel], isFavotire: Bool) {
        self.init()
        self.channels = channels
        self.isFavorite = isFavotire
        if isFavorite { hideCollection() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func addToFavorites(sender: Button) {
        let id = sender.tag
        let contains = storageService.favoritesId.contains(id)
        sender.isSelected = !contains
        contains ? storageService.delete(id) : storageService.add(id)
        favoriteChanels = channels.filter({ storageService.favoritesId.contains($0.id) })
        delegate?.reloadView(favoriteChanels, fromFavorites: isFavorite)
        if isFavorite {
            guard let cell = sender.cell, let indexPath = collectionView.indexPath(for: cell) else { return }
            collectionView.deleteItems(at: [indexPath])
            collectionView.reloadData()
        }
    }
    
    // MARK: - Private Properties
    
    private func setupViews() {
        addSubview(emptyLabel)
        addSubview(collectionView)
    }
    
    private func setupConstarints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: emptyLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: emptyLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            
            NSLayoutConstraint.init(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: collectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: collectionView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
        ])
    }
    
    private func hideCollection() {
            collectionView.isHidden = StorageService.shared.favoritesId.isEmpty
            emptyLabel.isHidden = !StorageService.shared.favoritesId.isEmpty
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension ChannelsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let urlString = "http://techslides.com/demos/sample-videos/small.mp4"
        guard let url = URL(string: urlString) else { return }
        delegate?.pushVideoPlayer(url)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFavorite ? favoriteChanels.count : channels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCell.cellId, for: indexPath) as! ChannelCell
        cell.networkService = networkService
        isFavorite ? cell.setupCell(whithChannel: favoriteChanels[indexPath.row]) : cell.setupCell(whithChannel: channels[indexPath.row])
        guard let id = cell.id else { return cell }
        cell.starButton.isSelected = storageService.favoritesId.contains(id)
        cell.starButton.tag = id
        cell.starButton.addTarget(self, action: #selector(addToFavorites(sender:)), for: .touchUpInside)
        if isFavorite { cell.starButton.cell = cell }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 16, height: 76)
    }
}
