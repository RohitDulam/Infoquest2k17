//
//  NotificationDetailsViewController.swift
//  infoquesttrial
//
//  Created by rohit on 25/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class NotificationDetailsViewController: UITableViewController {
    @IBOutlet weak var notiftitle: UILabel!
    let APPKEY = "SW5mb3F1ZXN0MjAxN0FwcEtleQ=="
    let logins = "https://jbgroup.org.in/sync/sync_mapp/iq_php/notification_expand.php"
    @IBOutlet weak var notifdetails: UILabel!
    let defaults = UserDefaults.standard
    var str = ""
    var notstr = ""
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        let re = CGRect(x: tableView.bounds.width / 2 - 15, y: 0.0, width: 30, height: 30)
        let activityIndicatorView = UIActivityIndicatorView(frame: re)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let headerView: UIView = UIView(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: tableView.bounds.height))
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.startAnimating()
        headerView.addSubview(activityIndicatorView)
        self.tableView.tableHeaderView = headerView
        self.tableView.isScrollEnabled = false
        let manager = Alamofire.SessionManager.default
        
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.request(logins, method: .post, parameters: ["APPKEY" : APPKEY, "Heading" : str], encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            let json = JSON(response.result.value)
            self.notiftitle.text = json[0]["Heading"].stringValue
            self.notifdetails.text = json[0]["Content"].stringValue
            
            
            self.tableView.reloadData()
            self.tableView.tableHeaderView = nil
            self.tableView.isScrollEnabled = true
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
