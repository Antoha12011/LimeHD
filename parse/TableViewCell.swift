//
//  TableViewCell.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}



/// НАСТРОЙКА SEARCH BAR

// let textFieldInsideUISearchBar = self.searchBar.value(forKey: "searchField") as? UITextField
// textFieldInsideUISearchBar?.textColor = UIColor.red
// textFieldInsideUISearchBar?.font = textFieldInsideUISearchBar?.font?.withSize(12)
//
// let labelInsideUISearchBar = textFieldInsideUISearchBar!.value(forKey: "placeholderLabel") as? UILabel
// labelInsideUISearchBar?.textColor = UIColor.red
