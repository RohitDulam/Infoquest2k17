//
//  PaperTableViewController.swift
//  infoquesttrial
//
//  Created by rohit on 20/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import SDWebImage
import MessageUI
import Alamofire
import SwiftyJSON
class PaperTableViewController: UITableViewController,MFMailComposeViewControllerDelegate {
    
    var index = 0
    var seguedata = ""
    let defaults = UserDefaults.standard

    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = seguedata
        img.image = #imageLiteral(resourceName: "PAPERPRESENTATION_DETAILS")
        tableView.separatorStyle = .none
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TableViewControllerStatic
        vc.seguedata = "PaperPresentation"
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CGFloat(250)
        }
        else {
            return UITableViewAutomaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "paperdetails", sender: self)
        }
        else {
            index = 2
        }
    }
    @IBAction func sendMail(_ sender: Any) {
        let subject = "IQ'17 Abstract Submission"
        let body = "Hello, Team Infoquest \r\n Name: \r\n Contact Number: \r\n College Name: \r\n Abstract Title: \r\n Event Reg ID: \r\n Attach your abstract as an attachment."
         let email = "infoquest@jbiet.edu.in"
       /*  let url = URL(string: "mailto:\(email)&subject=\(subject)&body=\(body)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
         UIApplication.shared.open(url!) */
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setSubject(subject)
        mail.setMessageBody(body, isHTML: true)
        mail.setToRecipients([email])
        present(mail, animated: true, completion: nil)
    }
    @IBAction func uploadAbstract(_ sender: Any) {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        let data = ["AUTHKEY" : defaults.value(forKey: "Key")!, "UserName" : defaults.value(forKey: "UserName")!]
        
        let urlppt = "https://jbgroup.org.in/sync/sync_mapp/iq_php/new_check_ppt_exists.php"
        manager.request(urlppt, method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            let json = JSON(response.result.value)
            
            if !json[0]["NotRegistered"].exists() {
                if !json[0]["AuthKeyError"].exists() {
                    if json[0]["Registered"].exists() {
                        let url = URL(string: "https://forms.zohopublic.com/bhanutejar07/form/Infoquest17/formperma/4g4BdjBg_4ddm6Ca623g8530G")
                        UIApplication.shared.open(url!)
                    }
                }
                else {
                    let alert = UIAlertController(title: "", message: "Some problem", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }else {
                let alert = UIAlertController(title: "", message: "Please Register first", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
