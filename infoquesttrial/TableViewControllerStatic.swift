//
//  TableViewControllerStatic.swift
//  infoquesttrial
//
//  Created by rohit on 23/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Toast_Swift



class TableViewControllerStatic: UITableViewController {
    var x = 0
    var priceperhead = 0
    var participants = 0
    var seguedata = ""
    var eventid = ""
    var str = ""
    var cstr = ""
    var imgurl = ""
    var eventname = ""
    var cos = ""
    var coss = ""
    var cosn = ""
    var cossn = ""
    var disc = "ALL THE PAYMENTS SHALL BE MADE AT THE VENUE ON THE DAYS OF IQ'17(16th,17th & 18th MARCH 2017). 10% OFF ON ALL DIGITAL TRANSACTIONS MADE (PREFERRED PAYTM)."
    var eventinhold = ""
    @IBOutlet weak var disclaimer: UITextView!
    
    @IBOutlet weak var iview: UIImageView!
   
    
    
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var rulesofevent: UILabel!
    
    
    @IBOutlet weak var co2number: UILabel!
    @IBOutlet weak var co2: UILabel!
    @IBOutlet weak var co1number: UILabel!
    @IBOutlet weak var co1: UILabel!
    @IBOutlet weak var pph: UILabel!
    @IBOutlet weak var parti: UILabel!
    @IBOutlet weak var descofevent: UILabel!
    
    let defaults = UserDefaults.standard
    
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
        self.tableView.tableHeaderView = headerView
        self.tableView.isScrollEnabled = false
       
        title = seguedata
        let data = ["APPKEY":"SW5mb3F1ZXN0MjAxN0FwcEtleQ==","EventName":seguedata]
        
        manager.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/eventdetails.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON{
            response in
            
            let json = JSON(response.result.value)
            
            
            let openstatus = json[0]["EventOpenStatus"].stringValue
            
            if openstatus == "1"{
                self.iview.isHidden = true
                self.descofevent.isHidden = true
                self.rulesofevent.isHidden = true
                self.disclaimer.isHidden = true
                self.co1.isHidden = true
                self.co2.isHidden = true
                self.co1number.isHidden = true
                self.co2number.isHidden = true
                self.pph.isHidden = true
                self.parti.isHidden = true
                self.register.isHidden = true
                let alertcontroller = UIAlertController(title: "", message: "Registrations have been closed for the event", preferredStyle: .alert)
                
                let yes = UIAlertAction(title: "OK", style: .default)
                alertcontroller.addAction(yes)
                
                self.present(alertcontroller, animated: true, completion: nil)
            }
            else {
                
            }
            
            self.str = json[0]["EventDescription"].stringValue
            self.cstr = json[0]["EventRules"].stringValue
            self.imgurl = json[0]["EventImageUrl"].stringValue
            self.participants = json[0]["EventParticipantNo"].intValue
            self.priceperhead = json[0]["EventPricePerHead"].intValue
            self.cos = json[0]["EventCoordinator1"].stringValue
            self.coss = json[0]["EventCoordinator2"].stringValue
            self.cosn = json[0]["EventCoNumber1"].stringValue
            self.cossn = json[0]["EventCoNumber2"].stringValue
            self.iview.sd_setImage(with: URL(string : self.imgurl))
            self.descofevent.text = self.str
            self.rulesofevent.text = self.cstr
            self.disclaimer.text = self.disc
            self.co1.text = self.cos
            self.co2.text = self.coss
            self.co1number.text = self.cosn
            self.co2number.text = self.cossn
            self.pph.text = String(self.priceperhead)
            self.parti.text = String(self.participants)
            
            
            self.tableView.reloadData()
            self.tableView.isScrollEnabled = true
            self.tableView.tableHeaderView = nil
            self.tableView.isHidden = false
        }
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(250)
        }
        else {
            return UITableViewAutomaticDimension
        }
    }
        
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(70)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func registerForEvent(_ sender: Any) {
        manager.session.configuration.timeoutIntervalForRequest = 120
        let alertController = UIAlertController(title: "Would you like to register?", message: "", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Proceed", style: .default) { (action) -> Void in
            
            if self.defaults.value(forKey: "Key") != nil {
                switch (self.seguedata) {
                case "Can you C","Googled","Gears of Rampage","Blur":
                    let amount = self.participants * self.priceperhead
                    let data = ["AUTHKEY":self.defaults.value(forKey: "Key")!,"UserName":self.defaults.value(forKey: "UserName")!,"EventName":self.seguedata,"Amount":amount]
                    
                    self.manager.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/registerevent.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON{
                        response in
                        let json = JSON(response.result.value)
                        self.eventid = json[0]["EventRegID"].stringValue
                        
                        if !json[0]["AuthKeyError"].exists(){
                            if !json[0]["ExceptionOccured"].exists(){
                                if !json[0]["RegistrationFailed"].exists() {
                                    if !json[0]["EventInHold"].exists() {
                                        if json[0]["RegistrationSuccess"].exists() {
                                            self.x = self.x + 1
                                            self.defaults.set(self.x, forKey: "eventregnumber")
                                            let alertController = UIAlertController(title: "", message: "Registered Successfully", preferredStyle: .alert)
                                            let no1Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                                
                                            }
                                            alertController.addAction(no1Action)
                                            self.present(alertController, animated: true, completion: nil)
                                        }
                                        else{
                                            
                                        }
                                    }
                                    else {
                                        let alertController = UIAlertController(title: "", message: "Event is on hold.Please go to the Registered events tab to look at the registered events", preferredStyle: .alert)
                                        let no2Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                            print("The event is on hold.")
                                        }
                                        let yes2Action = UIAlertAction(title: "GO", style: .default) { (action) -> Void in
                                            self.performSegue(withIdentifier: "bullshit", sender: self)
                                        }
                                        alertController.addAction(no2Action)
                                        alertController.addAction(yes2Action)
                                        self.present(alertController, animated: true, completion: nil)
                                    }
                                }
                                else {
                                    let alertController = UIAlertController(title: "", message: "Registration failed", preferredStyle: .alert)
                                    let no3Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                    }
                                    alertController.addAction(no3Action)
                                    self.present(alertController, animated: true, completion: nil)
                                }
                            }
                            else {
                                let alertController = UIAlertController(title: "", message: "Some problem with the server", preferredStyle: .alert)
                                let no4Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                }
                                alertController.addAction(no4Action)
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                        else {
                            let alertController = UIAlertController(title: "", message: "Auth key error", preferredStyle: .alert)
                            let no5Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                print("AAUTH KEY ERROR")
                            }
                            alertController.addAction(no5Action)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                    break
                default:
                    
                    let amount = self.participants * self.priceperhead
                    let data = ["AUTHKEY":self.defaults.value(forKey: "Key")!,"UserName":self.defaults.value(forKey: "UserName")!,"EventName":self.seguedata,"Amount":amount]
                    self.manager.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/new_final_register.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON{
                        response in
                            let json = JSON(response.result.value)
                        
                        if !json[0]["AuthKeyError"].exists(){
                            if !json[0]["ExceptionOccured"].exists(){
                                if !json[0]["RegistrationFailed"].exists() {
                                    if !json[0]["EventInHold"].exists() {
                                        if json[0]["RegistrationSuccess"].exists() {
                                            let alertController = UIAlertController(title: "", message: "Registered Successfully", preferredStyle: .alert)
                                            let no1Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                                print("The user has registered successfully")
                                            }
                                            alertController.addAction(no1Action)
                                            self.present(alertController, animated: true, completion: nil)
                                        }
                                        else{
                                            
                                        }
                                    }
                                    else {
                                        let alertController = UIAlertController(title: "", message: "Event is on hold.Please go to the Registered events tab to look at the registered events", preferredStyle: .alert)
                                        let no2Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                            print("The event is on hold.")
                                        }
                                        let yes2Action = UIAlertAction(title: "GO", style: .default) { (action) -> Void in
                                            self.performSegue(withIdentifier: "bullshit", sender: self)
                                        }
                                        alertController.addAction(no2Action)
                                        alertController.addAction(yes2Action)
                                        self.present(alertController, animated: true, completion: nil)
                                    }
                                }
                                else {
                                    let alertController = UIAlertController(title: "", message: "Registration failed", preferredStyle: .alert)
                                    let no3Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                    }
                                    alertController.addAction(no3Action)
                                    self.present(alertController, animated: true, completion: nil)
                                }
                            }
                            else {
                                let alertController = UIAlertController(title: "", message: "Some problem with the server", preferredStyle: .alert)
                                let no4Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                }
                                alertController.addAction(no4Action)
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                        else {
                            let alertController = UIAlertController(title: "", message: "Auth key error", preferredStyle: .alert)
                            let no5Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                print("AAUTH KEY ERROR")
                            }
                            alertController.addAction(no5Action)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                    break
                }
            }
            else {
                let alertController = UIAlertController(title: "", message: "Please log in to continue.", preferredStyle: .alert)
                let loginAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                    
                }
                alertController.addAction(loginAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
   
    }

    
}

