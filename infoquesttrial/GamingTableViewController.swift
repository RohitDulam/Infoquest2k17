//
//  GamingTableViewController.swift
//  infoquesttrial
//
//  Created by rohit on 28/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit

class GamingTableViewController: UITableViewController {
    
    var index = 0
    
    let gameurls = ["https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=MFj3JJ5WMuIEs8yU%2fMnk3iB7ZMD7cS%2b6I1wKFFd1UR8%3d&docid=0cc1863c4be264e53a8d01643ed069477&rev=1","https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=hNVQmvMBcfEYAr4GaiEzNCdcahjSdt60HB2ROT3xyFU%3d&docid=08f7974dce174416fab747f3ab83d9f89&rev=1"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gaming"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return gameurls.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.imgview.sd_setImage(with: URL(string : gameurls[indexPath.row]))
        

        return cell
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        
        performSegue(withIdentifier: "gaminginfo", sender: self)
    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! TableViewControllerStatic
        if index == 0 {
            vc.seguedata = "Blur"
        }
        else {
            
            vc.seguedata = "Clash of Clans"
            
        }
    }
 

}
