//
//  ViewControllerData.swift
//  infoquesttrial
//
//  Created by rohit on 21/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewControllerData: UITableViewController {
    
    @IBOutlet weak var event : UITextView?
    
    var str = ""
    var cstr = ""
    var imgurl = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        self.tableView.separatorStyle = .none
       // dataretrieve()
        
        
        

    }
    
    func dataretrieve() {
        
        
        let data = ["APPKEY":"SW5mb3F1ZXN0MjAxN0FwcEtleQ==","EventName":"Hack@IQ"]
        
        Alamofire.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/eventdetails.php", method: .post, parameters: data, encoding: URLEncoding.default, headers: nil).responseJSON{
            response in
            
            let json = JSON(response.result.value)
            
            //print(json)
            
            
            self.str = json[0]["EventDescription"].stringValue
            self.cstr = json[0]["EventRules"].stringValue
            self.imgurl = json[0]["EventImageUrl"].stringValue
            
            
           // print(self.cstr)
            //print(self.str)
            
            
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dataretrieve()
        
            if indexPath.row == 0 {
            let cell = Bundle.main.loadNibNamed("TableViewCellImage", owner: self, options: nil)?.first as! TableViewCellImage
            
            cell.iview.sd_setImage(with: URL(string : imgurl))
            print(imgurl)
            return cell
            }
            
        else if indexPath.row == 1{
            let cell = Bundle.main.loadNibNamed("TableViewCellEventDesc", owner: self, options: nil)?.first as! TableViewCellEventDesc
            
            cell.textView.text = str
            
            print(cell.textView.text)
            
            return cell
        }
        
            else {
            let cell = Bundle.main.loadNibNamed("TableViewCellEventDesc", owner: self, options: nil)?.first as! TableViewCellEventDesc
            
            cell.textView.text = cstr
            
            return cell
        }
        
       
        
        
    }
   /* override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return CGFloat(250)
    } */
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
