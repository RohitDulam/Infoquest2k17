//
//  TableViewCellImage.swift
//  infoquesttrial
//
//  Created by rohit on 21/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit

class TableViewCellImage: UITableViewCell {

    @IBOutlet weak var iview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
