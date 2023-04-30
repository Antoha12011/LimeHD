//
//  TableViewCell.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var discriptionLbl: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
