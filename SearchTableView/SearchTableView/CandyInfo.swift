//
//  CandyInfo.swift
//  SearchTableView
//
//  Created by 최희진 on 2023/09/30.
//

import UIKit

class CandyInfo: UIViewController{
    
    @IBOutlet weak var candyLabel: UILabel!
    var data : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        candyLabel.text = data
    }
}
