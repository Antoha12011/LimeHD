//
//  ViewController.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getJson()
        
        
    }
    
    
    
}




    




// MARK: - UITableViewDelegate / UITableViewDataSource


extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "⚙️"
        return cell
    }
    
}

