//
//  EventRegTableViewController.swift
//  infoquesttrial
//
//  Created by rohit on 28/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class EventRegTableViewController: UITableViewController {
    let APPKEY = "SW5mb3F1ZXN0MjAxN0FwcEtleQ=="
    let activityIndicatorView = UIActivityIndicatorView()
    var eventname = ""
    var eventid = ""
    let defaults = UserDefaults.standard
    var eventDetails = [String]()
    var regids = [String]()
    var teamids = [String]()
    var index = 0
    var tag = 1
    
    let managers = Alamofire.SessionManager.default
    
    @IBOutlet weak var sidemenu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        managers.session.configuration.timeoutIntervalForRequest = 120
        let re = CGRect(x: tableView.bounds.width / 2 - 15, y: 0.0, width: 30, height: 30)
        let activityIndicatorView = UIActivityIndicatorView(frame: re)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let headerView: UIView = UIView(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: tableView.bounds.height))
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.startAnimating()
        headerView.addSubview(activityIndicatorView)
        self.tableView.isScrollEnabled = false
        self.tableView.tableHeaderView = headerView
        self.tableView.separatorStyle = .none
        
        sidemenu.target = self.revealViewController()
        sidemenu.action = Selector("revealToggle:")
        title = "REGISTERED EVENTS"
        let data = ["AUTHKEY":defaults.value(forKey: "Key")!,"UserName":defaults.value(forKey: "UserName")!,"Email":defaults.value(forKey: "Email")!]
        managers.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/new_final_getall_registered_f_events.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success(let val) :
              //  print(val)
                break
            case .failure(let er):
                print(er)
                break
            }
            let json = JSON(response.result.value)
            let tevetns = json["TeamEvents"].arrayValue
            let sevents = json["SingleEvents"].arrayValue
         self.eventDetails.removeAll()
         self.regids.removeAll()
         self.teamids.removeAll()
            for eves in tevetns {
                self.eventDetails.append(eves["EventName"].stringValue)
                self.regids.append(eves["EventRegID"].stringValue)
                self.teamids.append(eves["TeamID"].stringValue)
            }
            for eves in sevents {
                self.eventDetails.append(eves["EventName"].stringValue)
                self.regids.append(eves["EventRegID"].stringValue)
                self.teamids.append(eves["TeamID"].stringValue)
            }
            
            self.tableView.reloadData()
            self.tableView.isScrollEnabled = true
            self.tableView.tableHeaderView = nil
            
            
        }
        

    }
    

    override func viewWillAppear(_ animated: Bool) {
        
      //  self.tableView.performSelector(onMainThread: Selector("data"), with: nil, waitUntilDone: true)
        data()
        
        
    }
    
    func data() {
        self.sidemenu.target = self.revealViewController()
        self.sidemenu.action = Selector("revealToggle:")
        self.managers.session.configuration.timeoutIntervalForRequest = 180
        let re = CGRect(x: self.tableView.bounds.width / 2 - 15, y: 0.0, width: 30, height: 30)
        let activityIndicatorView = UIActivityIndicatorView(frame: re)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let headerView: UIView = UIView(frame: CGRect(x:0, y:0, width: self.tableView.bounds.width, height: self.tableView.bounds.height))
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.startAnimating()
        headerView.addSubview(activityIndicatorView)
        self.tableView.isScrollEnabled = false
        self.tableView.tableHeaderView = headerView
        self.tableView.separatorStyle = .none
        
        
        self.title = "REGISTERED EVENTS"
        let data = ["AUTHKEY":self.defaults.value(forKey: "Key")!,"UserName":self.defaults.value(forKey: "UserName")!,"Email":self.defaults.value(forKey: "Email")!]
        self.managers.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/new_final_getall_registered_f_events.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success(let val) :
                let json = JSON(response.result.value)
                
                
                
                let tevetns = json["TeamEvents"].arrayValue
                let sevents = json["SingleEvents"].arrayValue
                self.eventDetails.removeAll()
                self.regids.removeAll()
                self.teamids.removeAll()
                for eves in tevetns {
                    self.eventDetails.append(eves["EventName"].stringValue)
                    self.regids.append(eves["EventRegID"].stringValue)
                    self.teamids.append(eves["TeamID"].stringValue)
                }
                for eves in sevents {
                    self.eventDetails.append(eves["EventName"].stringValue)
                    self.regids.append(eves["EventRegID"].stringValue)
                    self.teamids.append(eves["TeamID"].stringValue)
                    if eves["EventName"].stringValue == "PaperPresentation" {
                        if eves["TeamID"].stringValue != "" {
                            self.defaults.set(eves["TeamID"].stringValue, forKey: "PaperPresentation")
                        }
                    }
                }
                
                self.tableView.reloadData()
                self.tableView.isScrollEnabled = true
                self.tableView.tableHeaderView = nil
                break
            case .failure(let er):
                let alertcontroller = UIAlertController(title: "", message: "There is some problem with the internet connection", preferredStyle: .alert)
                let yes = UIAlertAction(title: "OK", style: .default)
                
                alertcontroller.addAction(yes)
                
                self.present(alertcontroller, animated: true, completion: nil)
                break
            }
            
            
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        
        return self.eventDetails.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("RegisterEventCell", owner: self, options: nil)?.first as! RegisterEventCell
        switch (eventDetails[indexPath.row]){
            case "Can you C","Blur","Gears of Rampage","Googled":
                cell.ename.text = "\(eventDetails[indexPath.row])"
                cell.regid.text = "\(regids[indexPath.row])"
                cell.tidl.isHidden = true
                cell.tid.isHidden = true
                return cell
            break
        default:
            cell.ename.text = "\(eventDetails[indexPath.row])"
            cell.regid.text = "\(regids[indexPath.row])"
            if teamids[indexPath.row] == ""{
                cell.tidl.isHidden = true
                cell.tid.isHidden = true
            }
            else {
                cell.tid.text = "\(teamids[indexPath.row])"
            }
            return cell
            
            break
        }
        

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        switch eventDetails[index] {
        case "Can you C","Blur","Googled","Gears of Rampage":
            performSegue(withIdentifier: "eventqr", sender: self)
            break
        default:
            if teamids[index] == ""{
                performSegue(withIdentifier: "teameventsqr", sender: self)
            }
            else {
                performSegue(withIdentifier: "eventqr", sender: self)
            }
            break
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "eventqr" {
            let vc = segue.destination as! RegEventDetailsQRViewController
            vc.eventname = eventDetails[index]
            vc.eventregid = regids[index]
            vc.etid = teamids[index]
        }
        else {
            let vc = segue.destination as! TeamQRTableViewController
            vc.ename = eventDetails[index]
            vc.eid = regids[index]
        }
        
        
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "backtohome", sender: self)
    }
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}

}
