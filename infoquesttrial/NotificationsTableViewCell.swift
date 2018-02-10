//
//  NotificationsTableViewCell.swift
//  infoquesttrial
//
//  Created by rohit on 25/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var heading: UILabel!
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
