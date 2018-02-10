//
//  RegisterEventCell.swift
//  infoquesttrial
//
//  Created by rohit on 28/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit

class RegisterEventCell: UITableViewCell {

   
    @IBOutlet weak var tidl: UILabel!
    @IBOutlet weak var regid: UILabel!
    @IBOutlet weak var ename: UILabel!
    @IBOutlet weak var tid: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
