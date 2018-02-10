//
//  ViewController.swift
//  infoquesttrial
//
//  Created by rohit on 19/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import  SwiftyJSON
import SnapKit

class ViewController: UIViewController {
    let defaults = UserDefaults.standard
    let APPKEY = "SW5mb3F1ZXN0MjAxN0FwcEtleQ=="
    let logins = "https://jbgroup.org.in/sync/sync_mapp/iq_php/login.php"
    var fkey : String = ""
    var key : String? = nil

    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var mail: UITextField!
    let manager = Alamofire.SessionManager.default
    @IBOutlet weak var actview: UIView!
    @IBOutlet weak var actindicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actview.isHidden = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func login(_ sender: Any) {
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        let email = mail.text!
        let password = pwd.text!
        
        let data = ["APPKEY":APPKEY,"email":email,"password":password]
         if email.isEmpty {
            
            mail.placeholder = "enter email again"
            
        }
        
        else if password.isEmpty {
            
            pwd.placeholder = "enter password again"
            
        }
        
        else {
            actview.isHidden = false
            actindicator.activityIndicatorViewStyle = .gray
            actindicator.hidesWhenStopped = true
            actindicator.startAnimating()
            actview.addSubview(actindicator)
            self.view.addSubview(actview)
            
            manager.request(logins, method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON{
                
                response in
                
                let json = JSON(response.result.value)
                if response.result.error == nil {
                    if !json[0]["AuthenticationError"].exists(){
                        let key = json[0]["Key"].stringValue
                        let uname = json[0]["UserName"].stringValue
                        let mail = json[0]["Email"].stringValue
                        if json[0]["Key"].exists() {
                            self.defaults.set(key, forKey: "Key")
                            self.defaults.set(uname, forKey: "UserName")
                            self.defaults.set(mail, forKey: "Email")
                            self.performSegue(withIdentifier: "segue", sender: self)
                        }
                        
                    }
                    else {
                        let alert = UIAlertController(title: "Authentication error, please enter your credentials correctly", message: "", preferredStyle: .alert)
                        
                        let actions = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) -> Void in
                             self.actview.isHidden = true
                        }
                        
                        alert.addAction(actions)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
                else {
                    let alert = UIAlertController(title: "There is some problem!", message: "", preferredStyle: .alert)
                    
                    let actions = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) -> Void in
                         self.actview.isHidden = true
                    }
                    
                    alert.addAction(actions)
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
           
        }
        
        
    }
    @IBAction func signup(_ sender: Any) {
        
        performSegue(withIdentifier: "seguesignup", sender: self)
    }
    @IBAction func skiplogin(_ sender: Any) {
        performSegue(withIdentifier: "skip", sender: self)
    }
    
    

}

