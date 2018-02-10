//
//  ContributorsTableViewController.swift
//  infoquesttrial
//
//  Created by rohit on 17/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit

class ContributorsTableViewController: UITableViewController {

    @IBOutlet weak var back: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        back.target = self.revealViewController()
        back.action = Selector("revealToggle:")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    

}
