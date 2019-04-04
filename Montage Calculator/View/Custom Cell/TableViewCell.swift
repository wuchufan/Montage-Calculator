//
//  TableViewCell.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-03-06.
//  Copyright © 2019 TIEC. All rights reserved.
//

import UIKit


class TableViewCell: UITableViewCell{
    

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellLabelNumber: UITextField!



    override func awakeFromNib() {
        super.awakeFromNib()
        


        // Initialization code

    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}

