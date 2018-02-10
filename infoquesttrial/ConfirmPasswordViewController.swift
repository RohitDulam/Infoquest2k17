//
//  ConfirmPasswordViewController.swift
//  infoquesttrial
//
//  Created by rohit on 08/02/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ConfirmPasswordViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let APPKEY = "SW5mb3F1ZXN0MjAxN0FwcEtleQ=="
    let forgots = "https://jbgroup.org.in/sync/sync_mapp/iq_php/updatepassword.php"
    let manager = Alamofire.SessionManager.default
    @IBOutlet weak var actindicator: UIActivityIndicatorView!
    @IBOutlet weak var actview: UIView!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var cpass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actview.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func confirmPass(_ sender: Any) {
        manager.session.configuration.timeoutIntervalForRequest = 120
        self.actview.isHidden = false
        actindicator.activityIndicatorViewStyle = .gray
        actindicator.startAnimating()
        actview.addSubview(actindicator)
        self.view.addSubview(actview)
        let data = ["APPKEY":APPKEY,"Email":defaults.value(forKey: "cmail")!,"Pass":pass.text!,"Cpass":cpass.text!]
        manager.request(forgots, method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            let json = JSON(response.result.value)
            
            if json[0]["Updated"].exists() {
                let alertController = UIAlertController(title: "", message: "Password has been changed successfully.", preferredStyle: .alert)
                let noAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                    self.performSegue(withIdentifier: "super", sender: self)
                }
                alertController.addAction(noAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                let alertController = UIAlertController(title: "", message: "There is some problem! Try again!!", preferredStyle: .alert)
                let noAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                    self.performSegue(withIdentifier: "super", sender: self)
                }
                alertController.addAction(noAction)
                self.present(alertController, animated: true, completion: nil)
            
            }
        }
    }
}
