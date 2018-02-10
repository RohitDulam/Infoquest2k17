//
//  TableViewCell.swift
//  infoquesttrial
//
//  Created by rohit on 19/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imgview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
