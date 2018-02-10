//
//  TestingViewController.swift
//  infoquesttrial
//
//  Created by rohit on 31/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TestingViewController: UITableViewController {
    let activityIndicatorView = UIActivityIndicatorView()
    let defautls = UserDefaults.standard
    @IBOutlet weak var clg: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var uname: UILabel!
    @IBOutlet weak var lname: UILabel!
    @IBOutlet weak var fname: UILabel!
    @IBOutlet weak var back: UIBarButtonItem!
    let manager = Alamofire.SessionManager.default
    override func viewDidLoad() {
        manager.session.configuration.timeoutIntervalForRequest = 120
        super.viewDidLoad()
        let re = CGRect(x: tableView.bounds.width / 2 - 15, y: 0.0, width: 30, height: 30)
        let activityIndicatorView = UIActivityIndicatorView(frame: re)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let headerView: UIView = UIView(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: tableView.bounds.height))
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.startAnimating()
        headerView.addSubview(activityIndicatorView)
        self.tableView.isScrollEnabled = false
        self.tableView.tableHeaderView = headerView
        title = "Profile"
        self.tableView.separatorStyle = .none
        back.target = self.revealViewController()
        back.action = Selector("revealToggle:")
        
        let data = ["AUTHKEY":defautls.value(forKey: "Key")!,"UserName":defautls.value(forKey: "UserName")!,"Email":defautls.value(forKey: "Email")!]
        
        Alamofire.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/profile.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON{
            response in
            
            let json = JSON(response.result.value)
            
            self.clg.text = json[0]["CollegeName"].stringValue
            self.phone.text = json[0]["PhoneNumber"].stringValue
            self.fname.text = json[0]["FirstName"].stringValue
            self.lname.text = json[0]["LastName"].stringValue
            self.uname.text = json[0]["UserName"].stringValue
            self.email.text = json[0]["Email"].stringValue
            
            self.tableView.reloadData()
            self.tableView.tableHeaderView = nil
            self.tableView.isScrollEnabled = true
        }
            
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
