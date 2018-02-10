//
//  ViewControllerSignup.swift
//  infoquesttrial
//
//  Created by rohit on 20/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//
import Alamofire
import UIKit
import SwiftyJSON

class ViewControllerSignup: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var clgname: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var cpwd: UITextField!
    
    
    @IBOutlet weak var actview: UIView!
    
    @IBOutlet weak var actindicator: UIActivityIndicatorView!
    let manager = Alamofire.SessionManager.default
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        fname.delegate = self
        lname.delegate  = self
        mail.delegate = self
        clgname.delegate = self
        number.delegate = self
        pwd.delegate = self
        cpwd.delegate = self

        self.actview.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(_ sender: Any) {
        
        manager.session.configuration.timeoutIntervalForRequest = 120
        self.actview.isHidden = false
        actindicator.activityIndicatorViewStyle = .gray
        actindicator.startAnimating()
        actview.addSubview(actindicator)
        self.view.addSubview(actview)
        let pawd = pwd.text!
        let finame = fname.text!
        let laname = lname.text!
        let cpawd = cpwd.text!
        let phonennumber = number.text!
        let collegenname = clgname.text!
        let emaill = mail.text!
        let appkey = "SW5mb3F1ZXN0MjAxN0FwcEtleQ=="
        
        let data = ["APPKEY":appkey,
                    "fname":finame,
                    "lname":laname,
                    "email":emaill,
                    "collegename":collegenname,
                    "phonenumber":phonennumber,
                    "password":pawd,
                    "cpassword":cpawd
        ]
        
        
        manager.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/register.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON{
            response in
            
            let json = JSON(response.result.value)
            
            
            if response.result.error == nil {
                if json[0]["Key"].exists() {
                    let alert = UIAlertController(title: "", message: "Registered Successfully", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default){
                        (action) -> Void in
                        self.actview.isHidden = true
                        self.performSegue(withIdentifier: "segueloginpage", sender: self)
                    }
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    self.performSegue(withIdentifier: "segueloginpage", sender: self)
                }
                else {
                    
                    let alert = UIAlertController(title: "", message: "Couldn't register, please try again", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default){
                        (action) -> Void in
                        self.actview.isHidden = true
                        self.performSegue(withIdentifier: "segueloginpage", sender: self)
                    }
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
            else {
                let alert = UIAlertController(title: "", message: "Couldn't register, please try again", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default){
                    (action) -> Void in
                    self.actview.isHidden = true
                    self.performSegue(withIdentifier: "segueloginpage", sender: self)
                }
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }

    @IBAction func back(_ sender: Any) {
        
        performSegue(withIdentifier: "loginsegue", sender: self)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
