//
//  TeamQRTableViewController.swift
//  infoquesttrial
//
//  Created by rohit on 20/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TeamQRTableViewController: UITableViewController {
    let tag = 1
    var ename : String!
    var etid = ""
    var eid : String!
    let defaults = UserDefaults.standard
    @IBOutlet weak var eventname: UILabel!
    @IBOutlet weak var teamid: UITextField!
    let manager = Alamofire.SessionManager.default
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.session.configuration.timeoutIntervalForRequest = 180
        eventname.text = ename
        let re = CGRect(x: tableView.bounds.width / 2 - 15, y: 0.0, width: 30, height: 30)
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
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(30)
    }
    

    
    @IBAction func register(_ sender: Any) {
        let idteam = ename+"\(teamid.text!)"
        let data = ["AUTHKEY" : defaults.value(forKey: "Key")! , "UserName" : defaults.value(forKey: "UserName")! , "EventName" : ename , "EventRegID" : eid , "TeamID": idteam]
        
        manager.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/getintoteam.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            let json = JSON(response.result.value)
            
            if json[0]["SuccessfullyAdded"].exists() {
                self.etid = idteam
                let alert = UIAlertController(title: "", message: "You have been successfully added to a team.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                {
                    (action) -> Void in
                    self.performSegue(withIdentifier: "teameventsqrcode", sender: self)
                    
                }
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            }
            else if json[0]["LimitExceededError"].exists() {
                let alert = UIAlertController(title: "", message: "The limit of team members in a team has been reached.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "", message: "Please try again, there was some problem.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RegEventDetailsQRViewController
        vc.eventregid = eid
        vc.etid = etid
        vc.eventname = ename
        vc.tag = tag
    }
}
