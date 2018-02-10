//
//  CodeViewController.swift
//  infoquesttrial
//
//  Created by rohit on 08/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CodeViewController: UIViewController {
    
    @IBOutlet weak var code: UITextField!
    var email = ""
    
    @IBOutlet weak var actindicator: UIActivityIndicatorView!
    @IBOutlet weak var actview: UIView!
    let APPKEY = "SW5mb3F1ZXN0MjAxN0FwcEtleQ=="
    let forgots = "https://jbgroup.org.in/sync/sync_mapp/iq_php/verifycode.php"
    let manager = Alamofire.SessionManager.default
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actview.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func codesub(_ sender: Any) {
        manager.session.configuration.timeoutIntervalForRequest = 120
        self.actview.isHidden = false
        actindicator.activityIndicatorViewStyle = .gray
        actindicator.startAnimating()
        self.actview.addSubview(actindicator)
        self.view.addSubview(actview)
        
        let data = ["APPKEY":APPKEY,"Email": email, "Code": code.text!]
        
        manager.request(forgots, method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            let json = JSON(response.result.value)
            
            
            
            if !json[0]["InvalidCode"].exists() {
                if !json[0]["AppKeyError"].exists() {
                    if json[0]["CodeMatch"].exists() {
                        self.performSegue(withIdentifier: "passc", sender: self)
                    }
                    else {
                        let alertController = UIAlertController(title: "", message: "There is some problem", preferredStyle: .alert)
                        let noAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                            self.actview.isHidden = true
                            self.performSegue(withIdentifier: "errorc", sender: self)
                        }
                        alertController.addAction(noAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        
                    }
                    
                }
                else {
                    let alertController = UIAlertController(title: "", message: "There is some problem", preferredStyle: .alert)
                    let noAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                        self.actview.isHidden = true
                        self.performSegue(withIdentifier: "errorc", sender: self)
                    }
                    alertController.addAction(noAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
            else {
                
                let alertController = UIAlertController(title: "", message: "There is some problem", preferredStyle: .alert)
                let noAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                    self.actview.isHidden = true
                    self.performSegue(withIdentifier: "errorc", sender: self)
                }
                alertController.addAction(noAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "errorc"{
            
            
        }
        else {
            
            
            
            
        }
    }

}
