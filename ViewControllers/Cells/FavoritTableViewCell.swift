//
//  FavoritTableViewCell.swift
//  parse
//
//  Created by Антон Павлов on 01.05.2023.
//

import UIKit

final class FavoritTableViewCell: UITableViewCell {

    @IBOutlet weak var favoritImage: UIImageView!
    @IBOutlet weak var favoritTitle: UILabel!
    @IBOutlet weak var favoritDescription: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        favoritImage.image = nil
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
