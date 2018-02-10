//
//  PptRemarksViewController.swift
//  infoquesttrial
//
//  Created by rohit on 25/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class PptRemarksViewController: UITableViewController {
    var tid = ""
    @IBOutlet weak var remarks: UILabel!
    @IBOutlet weak var remarksmatter: UILabel!
    @IBOutlet weak var submitted: UILabel!
    @IBOutlet weak var verified: UILabel!
    let defaults = UserDefaults.standard
    var titles = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titles
        tableView.separatorStyle = .none
        remarks.isHidden = true
        remarksmatter.isHidden = true
        submitted.isHidden = true
        verified.isHidden = true
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        let data = ["AUTHKEY" : defaults.value(forKey: "Key")! , "PPT_Title" : titles , "TeamID" : tid]
        manager.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/new_get_ppt_status.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            let json = JSON(response.result.value)
            
            if json[0]["Remarks"].exists() {
                if json[0]["Remarks"].stringValue == "" {
                    self.remarksmatter.isHidden = true
                    self.remarks.isHidden = true
                }
                else {
                    self.remarksmatter.isHidden = false
                    self.remarks.isHidden = false
                    self.remarks.text = json[0]["Remarks"].stringValue
                }
                
                if json[0]["SubmittedStatus"].stringValue == "1"{
                    self.submitted.text = "SUBMITTED"
                }
                    
                else {
                    self.submitted.text = "NOT SUBMITTED"
                }
                
                if json[0]["VerifiedStatus"].stringValue == "1" {
                    self.verified.text = "VERIFIED"
                }
                else {
                    self.verified.text = "NOT VERIFIED"
                }
            }
            
            self.tableView.reloadData()
            self.submitted.isHidden = false
            self.verified.isHidden = false
            
        }
    
        
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
}
