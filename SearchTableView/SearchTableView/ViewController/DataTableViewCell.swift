//
//  DataTableViewCell.swift
//  SearchTableView
//
//  Created by 최희진 on 2023/09/30.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(data: String) {
        dataLabel.text = data
    }
}
