//
//  NotificationsTableViewController.swift
//  infoquesttrial
//
//  Created by rohit on 25/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NotificationsTableViewController: UITableViewController {
    @IBOutlet weak var sidemenu: UIBarButtonItem!
    let APPKEY = "SW5mb3F1ZXN0MjAxN0FwcEtleQ=="
    let logins = "https://jbgroup.org.in/sync/sync_mapp/iq_php/notifications_main.php"
    let defaults = UserDefaults.standard
    var bodies = [String]()
    var titles = [String]()
    var index = 0
    var ts = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications"
        
        sidemenu.target = self.revealViewController()
        sidemenu.action = Selector("revealToggle:")
        let re = CGRect(x: tableView.bounds.width / 2 - 15, y: 0.0, width: 30, height: 30)
        let activityIndicatorView = UIActivityIndicatorView(frame: re)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let headerView: UIView = UIView(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: tableView.bounds.height))
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.startAnimating()
        headerView.addSubview(activityIndicatorView)
        self.tableView.tableHeaderView = headerView
        self.tableView.isScrollEnabled = false
        self.tableView.separatorStyle = .none
        
        let manager = Alamofire.SessionManager.default
        
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.request(logins, method: .post, parameters: ["APPKEY" : APPKEY], encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            let json = JSON(response.result.value)
            
            
            for i in json.arrayValue {
                self.titles.append(i["Heading"].stringValue)
                self.bodies.append(i["Profileimg"].stringValue)
                self.ts.append(i["Timestamp"].stringValue)
            }
            
           
            self.tableView.reloadData()
            self.tableView.tableHeaderView = nil
            self.tableView.isScrollEnabled = true
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sidemenu.target = self.revealViewController()
        sidemenu.action = Selector("revealToggle:")
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
        
            return titles.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("NotificationsTableViewCell", owner: self, options: nil)?.first as! NotificationsTableViewCell
        index = indexPath.row
        
        cell.iview.sd_setImage(with: URL(string : bodies[indexPath.row]))
        cell.heading.text = titles[indexPath.row]
        cell.timestamp.text = ts[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "notificationdetails", sender: self)
    }
    

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! NotificationDetailsViewController
        vc.str = titles[index]
        
    }
    

}
