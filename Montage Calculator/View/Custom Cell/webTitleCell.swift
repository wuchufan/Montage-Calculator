//
//  webTitleCell.swift
//  Montage Calculator
//
//  Created by TIEC on 2019-04-15.
//  Copyright © 2019 TIEC. All rights reserved.
//

import UIKit

class webTitleCell: UITableViewCell {

    @IBOutlet weak var webArticleImage: UIImageView!
    @IBOutlet weak var webArticleTitle: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()

        webArticleTitle.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        webArticleTitle.numberOfLines = 0
        print("in cell:\(webArticleTitle.frame.height)")
//        webArticleImage.contentMode = .scaleAspectFit
//         .scaleAspectFill
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
