//
//  TableViewController.swift
//  infoquesttrial
//
//  Created by rohit on 19/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {
    let defaults = UserDefaults.standard
    var inflag = 0
    var flag = 0
    var index = 0
    var indexteam = 0
    var teamnames = [String] ()
    var teampics = [String] ()
    var x: String = ""
    let furls = ["https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=vki67mtPb6h4EbrJ%2b9BtM5mWe5mkUvBTBnxxo9lW2ak%3d&docid=05bd04c61f773482b9007d29bb5e0647e&rev=1",
        "https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=g%2frfDnhVTceJXTwDYqeNPXcEMzL5Abf1s%2fdGGqIYIz8%3d&docid=0cd682a6b1b1a479aba374b9af7c1b754&rev=1",
        "https://jbiet-my.sharepoint.com/personal/infoquest_jbiet_edu_in/_layouts/15/guestaccess.aspx?docid=107251d24f97946e9bced0c65022d309f&authkey=Aew4KPvhtxVQGVzit_xVS7k",
        "https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=ttb6YHhHaUaE8IkeO%2fpyLfCQ6F7l6QN1%2fuUyaLnEWn8%3d&docid=0365c7d66afdc4dcc8dc6f07af45ebc2b&rev=1"]
    let identifurls = ["featured","other","sponsors","team"]

    @IBOutlet weak var lgot: UIBarButtonItem!
    @IBAction func logout(_ sender: Any) {
        
        if defaults.value(forKey: "Key") != nil {
            let alertController = UIAlertController(title: "", message: "Do u want to Logout?", preferredStyle: .alert)
            
            
            let yesAction = UIAlertAction(title: "Logout", style: .default) { (action) -> Void in
                
                
                self.defaults.removeObject(forKey: "Key")
                self.defaults.removeObject(forKey: "UserName")
                self.defaults.removeObject(forKey: "Email")
                
                self.flag = 1
                
                self.performSegue(withIdentifier: "seguelogout", sender: self)
                
                
            }
            
            let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
                
            }
            
            
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "REGISTER!!", message: "", preferredStyle: .alert)
            
            let yesaction = UIAlertAction(title: "Register", style: .default) { (action) -> Void in
                
                self.performSegue(withIdentifier: "seguelogout", sender: self)
                
            }
            let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
                
            }
            
            
            alertController.addAction(yesaction)
            alertController.addAction(noAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    @IBOutlet weak var btn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "INFOQUEST 2K17"
      
       
        btn.target = self.revealViewController()
        btn.action = Selector("revealToggle:")
        
        Alamofire.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/teamiq.php").responseJSON {
            response in
            
            let json = JSON(response.result.value)
            
            self.indexteam = json.count
            
            for i in 0...(self.indexteam) {
                self.teamnames.append(json[i]["Team_IQ_Name"].stringValue)
                self.teampics.append(json[i]["Team_IQ_Image"].stringValue)
                
            }
            
            self.tableView.reloadData()
           
        }
    
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        if index == 3 {
            performSegue(withIdentifier: "teamdetails", sender: self)
        }
        else {
            performSegue(withIdentifier: "seguemultiple", sender: self)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return furls.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        
        cell.imgview.sd_setImage(with: URL(string: furls[indexPath.row]))
        //index = indexPath.row

        return cell
    }
 

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguemultiple"{
            
            let vc = segue.destination as! TableViewController1
            vc.str = identifurls[index]
        }
        else if segue.identifier == "seguelogout"{
        }
        else if segue.identifier == "teamdetails"{
            
            let vc = segue.destination as! TeamDetailsTableViewController
            
            vc.str = identifurls[index]
            vc.teamnames = teamnames
            vc.teampics = teampics
            vc.indexteam = indexteam
            
        }
        else {
            
        }
    }
 
    @IBAction func tore(_ sender: Any) {
        performSegue(withIdentifier: "fromhome", sender: self)
    } 

}
