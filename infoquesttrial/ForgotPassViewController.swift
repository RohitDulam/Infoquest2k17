//
//  ForgotPassViewController.swift
//  infoquesttrial
//
//  Created by rohit on 01/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ForgotPassViewController: UIViewController {
   
    let defaults = UserDefaults.standard
    
    let APPKEY = "SW5mb3F1ZXN0MjAxN0FwcEtleQ=="
    let forgots = "https://jbgroup.org.in/sync/sync_mapp/iq_php/forgotpassword.php"
    let manager = Alamofire.SessionManager.default
    @IBOutlet weak var actview: UIView!
    @IBOutlet weak var actindicator: UIActivityIndicatorView!
    @IBOutlet weak var forgot: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actview.isHidden = true
       
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
    @IBAction func codesubmission(_ sender: Any) {
        manager.session.configuration.timeoutIntervalForRequest = 120
        self.actview.isHidden = false
        actindicator.activityIndicatorViewStyle = .gray
        actindicator.startAnimating()
        actview.addSubview(actindicator)
        self.view.addSubview(actview)
         let data = ["APPKEY":APPKEY,"Email":forgot.text!] as [String : Any]
        
        manager.request(forgots, method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            let json = JSON(response.result.value)
            
            
            
            if (!json[0]["MailNotfoundError"].exists()) {
                 if (!json[0]["UpdateError"].exists()){
                    if(!json[0]["MailNotSentError"].exists()){
                        if(!json[0]["AuthKeyError"].exists()){
                            if(!json[0]["MailSent"].exists()){
                                
                                let alertController = UIAlertController(title: "", message: "There is some problem", preferredStyle: .alert)
                                let noAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                    self.actview.isHidden = true
                                }
                                alertController.addAction(noAction)
                                self.present(alertController, animated: true, completion: nil)
                                
                                
                            }
                            else {
                                self.defaults.set(self.forgot.text, forKey: "cmail")
                                self.performSegue(withIdentifier: "code", sender: self)
                            }
                        }
                        else {
                            let alertController = UIAlertController(title: "", message: "There is some problem", preferredStyle: .alert)
                            let noAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                self.actview.isHidden = true
                            }
                            alertController.addAction(noAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                    else {
                        let alertController = UIAlertController(title: "", message: "There is some problem", preferredStyle: .alert)
                        let noAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                            self.actview.isHidden = true
                        }
                        alertController.addAction(noAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                 else {
                    let alertController = UIAlertController(title: "", message: "There is some problem", preferredStyle: .alert)
                    let noAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                        self.actview.isHidden = true
                    }
                    alertController.addAction(noAction)
                    self.present(alertController, animated: true, completion: nil)
                }
               
                
            }
            else {
                
                let alertController = UIAlertController(title: "", message: "Mail not fouund", preferredStyle: .alert)
                let noAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                    self.actview.isHidden = true
                }
                alertController.addAction(noAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CodeViewController
        
        vc.email = forgot.text!
    }

}
