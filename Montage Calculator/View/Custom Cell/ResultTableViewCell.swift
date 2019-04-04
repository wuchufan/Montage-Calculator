//
//  ResultTableViewCell.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-03-07.
//  Copyright © 2019 TIEC. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var typeOfResult: UILabel!
    @IBOutlet weak var result: UILabel!
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
