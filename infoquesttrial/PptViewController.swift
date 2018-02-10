//
//  PptViewController.swift
//  infoquesttrial
//
//  Created by rohit on 24/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PptViewController: UITableViewController {
    var ttl = ""
    var titles = [String]()
    let manager = Alamofire.SessionManager.default
    let defaults = UserDefaults.standard
    var tid = ""
    
    @IBOutlet weak var sidemenu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        manager.session.configuration.timeoutIntervalForRequest = 120
        sidemenu.target = self.revealViewController()
        sidemenu.action = Selector("revealToggle:")
        let data = ["AUTHKEY":defaults.value(forKey: "Key")! , "UserName" : defaults.value(forKey: "UserName")!, "EventName" : "PaperPresentation" ]
       
        manager.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/new_getall_ppt_regids.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            let json = JSON (response.result.value)
            
            self.tid = json[0]["TeamID"].stringValue
            for i in 0...json.count {
                self.titles.append(json[i]["PPT_Title"].stringValue)
                
            }
            
            self.tableView.reloadData()
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sidemenu.target = self.revealViewController()
        sidemenu.action = Selector("revealToggle:")
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = "\(titles[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ttl = titles[indexPath.row]
        performSegue(withIdentifier: "pptremarks", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pptremarks" {
            let vc = segue.destination as! PptRemarksViewController
            vc.titles = ttl
            vc.tid = tid 
        }
    }
 

}
