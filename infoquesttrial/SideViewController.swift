//
//  SideViewController.swift
//  infoquesttrial
//
//  Created by rohit on 28/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit

class SideViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let defaults = UserDefaults.standard
    
    let names = ["Profile","Registered Events","Contributors","Home","Location","Track my paper","Notifications","About Infoquest", "Contact Us"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            if defaults.value(forKey: "Key") != nil {
                performSegue(withIdentifier: "testing", sender: self)
            }
            else {
                let alertController = UIAlertController(title: "", message: "Please do register first", preferredStyle: .alert)
                let no3Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                }
                alertController.addAction(no3Action)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        else if indexPath.row == 3 {
            performSegue(withIdentifier: "testinghome", sender: self)
        }
        else if indexPath.row == 0{
            
            if defaults.value(forKey: "Key") != nil {
                performSegue(withIdentifier: "profile", sender: self)
            }
            else {
                let alertController = UIAlertController(title: "", message: "Please do register first", preferredStyle: .alert)
                let no3Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                }
                alertController.addAction(no3Action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        else if indexPath.row == 4 {
            performSegue(withIdentifier: "maps", sender: self)
            
        }
        else if indexPath.row == 2{
            performSegue(withIdentifier: "contributors", sender: self)
        }
        else if indexPath.row == 5{
            
            if defaults.value(forKey: "Key") != nil {
                performSegue(withIdentifier: "pptstatus", sender: self)
            }
            else {
                let alertController = UIAlertController(title: "", message: "Please do register first", preferredStyle: .alert)
                let no3Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                }
                alertController.addAction(no3Action)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        else if indexPath.row == 6 {
            performSegue(withIdentifier: "notifications", sender: self)
        }
        else if indexPath.row == 7 {
            let alertController = UIAlertController(title: "INFOQUEST2K17", message: "Infoquest is a National Level Technical Symposium conducted by the Departments of Computer Science & Information Technology of JBIET", preferredStyle: .alert)
            let no3Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            }
            alertController.addAction(no3Action)
            self.present(alertController, animated: true, completion: nil)
            
        }
        else if indexPath.row == 8 {
            
            let alertController = UIAlertController(title: "", message: "Website - www.infoquest2017.com  For any queries please feel free to mail us at infoquest@jbiet.in. Any problems related to the app, call 7416837581-Rohit ", preferredStyle: .alert)
            let no3Action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            }
            alertController.addAction(no3Action)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
