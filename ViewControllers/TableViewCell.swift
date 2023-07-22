//
//  TableViewCell.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var broadcastNameLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var channelLogoImageView: UIImageView!
    @IBOutlet weak var starButton: UIButton!
    
    private var starButtonIsActive = false
    
    
    @IBAction func starButtonTapped(_ sender: Any) {
        starButtonIsActive ? deleteChannel(): saveChannel()
        starButtonIsActive.toggle()
        starButton.tintColor = getStarButtonTintColor()
    }
    
    private func saveChannel() {
        let favoriteChannel = FavoriteChannel()
        favoriteChannel.name = channelNameLabel.text ?? "No Channel Name"
        favoriteChannel.title = broadcastNameLabel.text ?? "No Broadcast Name"
        StorageManager.shared.save(favoriteChannel: favoriteChannel)
        print("БАЗА: ВНЕСЕНО ЗНАЧЕНИЕ \(favoriteChannel.name)")
    }
    
    private func deleteChannel() {
        let favoriteChannel = FavoriteChannel()
        favoriteChannel.name = channelNameLabel.text ?? "No Channel Name"
        StorageManager.shared.delete(favoriteChannel: favoriteChannel)
        print("БАЗА: УДАЛЕНО ЗНАЧЕНИЕ \(favoriteChannel.name)")
    }
    
    private func getStarButtonTintColor() -> UIColor {
        starButtonIsActive ? #colorLiteral(red: 0, green: 0.4610033035, blue: 1, alpha: 1) : #colorLiteral(red: 0.4501188397, green: 0.4546305537, blue: 0.48499614, alpha: 1)
    }
    static let identifier = "cell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        channelLogoImageView.image = nil
    }
    
    func configure(with channelName: String, channelTitle: String, image: String, isStarButtonActive: Bool) {
        channelNameLabel.text = channelName
        broadcastNameLabel.text = channelTitle
        ImageManager.shared.fetchImage(from: image) { [weak self] data in
            guard let self = self else { return }
            self.channelLogoImageView.image = UIImage(data: data)
        }
    }
    
    @IBAction func favoriteBtn(_ sender: Any) {
        print("Кнопка нажата")
    }
    
    override public var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame =  newValue
            frame.size.height -= 10
            super.frame = frame
        }
    }
    
    
}
