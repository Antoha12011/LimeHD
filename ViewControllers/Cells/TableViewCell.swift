//
//  TableViewCell.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var discriptionLbl: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        myImage.image = nil
    }
    
    @IBAction func favoriteBtn(_ sender: Any) {
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
