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
