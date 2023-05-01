//
//  FavoritTableViewCell.swift
//  parse
//
//  Created by Антон Павлов on 01.05.2023.
//

import UIKit

class FavoritTableViewCell: UITableViewCell {

    @IBOutlet weak var favoritImage: UIImageView!
    @IBOutlet weak var favoritTitle: UILabel!
    @IBOutlet weak var favoritDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
