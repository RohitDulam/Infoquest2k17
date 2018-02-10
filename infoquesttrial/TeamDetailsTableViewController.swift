//
//  TeamDetailsTableViewController.swift
//  infoquesttrial
//
//  Created by rohit on 17/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit

class TeamDetailsTableViewController: UITableViewController {
    
    var teamnames = [String] ()
    var teampics = [String] ()
    var indexteam = 0
    var str : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        let re = CGRect(x: tableView.bounds.width / 2, y: 0.0, width: 30, height: 30)
        let activityIndicatorView = UIActivityIndicatorView(frame: re)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let headerView: UIView = UIView(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: tableView.bounds.height))
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.startAnimating()
        headerView.addSubview(activityIndicatorView)
        self.tableView.tableHeaderView = headerView
        self.tableView.isScrollEnabled = false
        
        self.tableView.reloadData()
        self.tableView.tableHeaderView = nil
        self.tableView.isScrollEnabled = true
        title = "Team@INFOQUEST"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return indexteam
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(300)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = Bundle.main.loadNibNamed("TeamTableViewCell", owner: self, options: nil)?.first as! TeamTableViewCell
     cell.namess.text = teamnames[indexPath.row]
     cell.picss.sd_setImage(with: URL(string : teampics[indexPath.row]))

        return cell
    }
 

}
