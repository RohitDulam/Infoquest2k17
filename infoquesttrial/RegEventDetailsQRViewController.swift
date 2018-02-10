//
//  RegEventDetailsQRViewController.swift
//  infoquesttrial
//
//  Created by rohit on 30/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class RegEventDetailsQRViewController: UITableViewController {
    var tag = 0
    var eventname = ""
    var eventregid = ""
    var etid = ""
    let defaults = UserDefaults.standard
    let activityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var descdirections: UILabel!
    @IBOutlet weak var certificate: UILabel!
    @IBOutlet weak var payback: UILabel!
    @IBOutlet weak var attended: UILabel!
    @IBOutlet weak var paid: UILabel!
    @IBOutlet weak var qr: UIImageView!
    @IBOutlet weak var backbuttonstatus: UITableViewCell!
    let manager = Alamofire.SessionManager.default
    override func viewDidLoad() {
        manager.session.configuration.timeoutIntervalForRequest = 120
        title = eventname
        super.viewDidLoad()
        if tag != 1 {
            backbuttonstatus.isHidden = true
        }
        self.tableView.separatorStyle = .none
        let re = CGRect(x: tableView.bounds.width / 2 - 15, y: 0.0, width: 30, height: 30)
        let activityIndicatorView = UIActivityIndicatorView(frame: re)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let headerView: UIView = UIView(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: tableView.bounds.height))
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.startAnimating()
        headerView.addSubview(activityIndicatorView)
        self.tableView.tableHeaderView = headerView
        self.tableView.isScrollEnabled = false
        
        switch eventname {
        case "Googled","Can you C","Blur","Gears of Rampage" :
         
            singlevent()
            break
            
        default:
            multievent()
            
            break
        }

        
    }
    @IBAction func unwinding(_ sender: Any) {
        performSegue(withIdentifier: "unwind", sender: self)
        
    }
    
    func singlevent (_: Void) {
        manager.session.configuration.timeoutIntervalForRequest = 180
        let data = ["AUTHKEY":defaults.value(forKey: "Key")!,"UserName":defaults.value(forKey: "UserName")!,"EventName":eventname,"EventRegID":eventregid]
        manager.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/event_full_details.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success(let val):
                
                let json = JSON(response.result.value)
                
                if json[0]["PaidStatus"].stringValue == "0"{
                    self.paid.text = "PAID"
                    self.paid.textColor = UIColor.red
                }
                else {
                    self.paid.text = "PAID"
                    self.paid.textColor = UIColor.green
                }
                if json[0]["AttendedStatus"].stringValue == "0"{
                    self.attended.text = "ATTENDED"
                    self.attended.textColor = UIColor.red
                }
                else {
                    self.attended.text = "ATTENDED"
                    self.attended.textColor = UIColor.green
                }
                if json[0]["CertificateStatus"].stringValue == "0"{
                    self.certificate.text = "CERTIFICATE"
                    self.certificate.textColor = UIColor.red
                }
                else {
                    self.certificate.text = "CERTIFICATE"
                    self.certificate.textColor = UIColor.green
                }
                if json[0]["RefundStatus"].stringValue == "0"{
                    self.payback.text = "PAYBACK"
                    self.payback.textColor = UIColor.red
                }
                else {
                    self.payback.text = "PAYBACK"
                    self.payback.textColor = UIColor.green
                }
                
                
                self.qr.sd_setImage(with: URL(string : json[0]["QrUrl"].stringValue))
                
                self.tableView.reloadData()
                self.tableView.tableHeaderView = nil
                self.tableView.isScrollEnabled = true
                break
                
            case .failure(let er):
                let alertcontroller = UIAlertController(title: "", message: "There is some problem with the internet connection", preferredStyle: .alert)
                let yes = UIAlertAction(title: "OK", style: .default)
                
                alertcontroller.addAction(yes)
                
                self.present(alertcontroller, animated: true, completion: nil)
                break
                
            default:
                break
            }
            
        }
        
    }
    func multievent() {
        manager.session.configuration.timeoutIntervalForRequest = 180
        let data = ["AUTHKEY":defaults.value(forKey: "Key")!,"UserName":defaults.value(forKey: "UserName")!,"EventName":eventname,"EventRegID":eventregid,"TeamID":etid]
        
        manager.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/new_event_full_details.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success( _):
                let json = JSON(response.result.value)
                
                if json[0]["PaidStatus"].stringValue == "0"{
                    self.paid.text = "PAID"
                    self.paid.textColor = UIColor.red
                }
                else {
                    self.paid.text = "PAID"
                    self.paid.textColor = UIColor.green
                }
                if json[0]["AttendedStatus"].stringValue == "0"{
                    self.attended.text = "ATTENDED"
                    self.attended.textColor = UIColor.red
                }
                else {
                    self.attended.text = "ATTENDED"
                    self.attended.textColor = UIColor.green
                }
                if json[0]["CertificateStatus"].stringValue == "0"{
                    self.certificate.text = "CERTIFICATE"
                    self.certificate.textColor = UIColor.red
                }
                else {
                    self.certificate.text = "CERTIFICATE"
                    self.certificate.textColor = UIColor.green
                }
                if json[0]["RefundStatus"].stringValue == "0"{
                    self.payback.text = "PAYBACK"
                    self.payback.textColor = UIColor.red
                }
                else {
                    self.payback.text = "PAYBACK"
                    self.payback.textColor = UIColor.green
                }
                self.qr.sd_setImage(with: URL(string : json[0]["TeamQRUrl"].stringValue))
                self.tableView.reloadData()
                self.tableView.tableHeaderView = nil
                self.tableView.isScrollEnabled = true
                break
            case .failure( _):
                let alertcontroller = UIAlertController(title: "", message: "There is some problem with the internet", preferredStyle: .alert)
                let yes = UIAlertAction(title: "OK", style: .default)
                
                alertcontroller.addAction(yes)
                
                self.present(alertcontroller, animated: true, completion: nil)
                
                break
            }
            
            
        }
    }

    @IBAction func refresh(_ sender: Any) {
        let re = CGRect(x: tableView.bounds.width / 2 - 15, y: 0.0, width: 30, height: 30)
        let activityIndicatorView = UIActivityIndicatorView(frame: re)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let headerView: UIView = UIView(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: tableView.bounds.height))
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.startAnimating()
        headerView.addSubview(activityIndicatorView)
        self.tableView.tableHeaderView = headerView
        self.tableView.isScrollEnabled = false
        switch eventname {
        case "Googled","Can you C","Blur","Gears of Rampage" :
            
            singlevent()
            break
            
        default:
            multievent()
            
            break
        }
    }


}
