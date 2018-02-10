//
//  TeamTableViewCell.swift
//  infoquesttrial
//
//  Created by rohit on 17/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import SDWebImage
class TeamTableViewCell: UITableViewCell {
    

    @IBOutlet weak var namess: UILabel!
    @IBOutlet weak var picss: UIImageView!
    @IBOutlet weak var names: UILabel!
    @IBOutlet weak var pics: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
