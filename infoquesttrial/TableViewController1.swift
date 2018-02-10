//
//  TableViewController1.swift
//  infoquesttrial
//
//  Created by rohit on 19/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class TableViewController1: UITableViewController {
    
    var teamnames = [String] ()
    var teampics = [String] ()
    var sponsordets = [String] ()
    let defaults = UserDefaults.standard
    
    var str : String = ""
    var indexteam = 0
    var index = 0
    let furls = ["https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=99RCikpPpE9Z7TunRy2xIlpLrdKPbYM7HtjU3akMbC4%3d&docid=0107a9234af674bce8ada7d085f75fc85&rev=1","https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=WyjX0pJiblz5eShZm9G3%2buhxwdECQs5z%2fZ7a6Xgsybo%3d&docid=094daac32927e49bbacb5a42c527d4265&rev=1","https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=XhWWmuQ8rvDRqW%2fKyq0Cky9AofzUVFTlVhrxsFQipnU%3d&docid=07f70d7bff6d14564b06c071e9c765741&rev=1",
        "https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=KVCF6M1OfI09mWNl58YGQqRiZxOyYuOL1yVulQrB5AM%3d&docid=07217da05dd594c0caddc4803c2483092&rev=1"]
    
    let otherurls = ["https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=5ya3p8MM9ZrtK03iwembC%2fhMX1Bx70dwHHBYYdRynPM%3d&docid=0d3f5f5ed4ff84a5d94181fa9ff56cd44&rev=1",
        "https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=XiTcIflbBvvFaK10vtGSoCteRdDHsAgO2gwh7yhmWFw%3d&docid=0337303b652194353b61a6d552cf127ea&rev=1",
        "https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=0tcsTwkFOQ1EPiPeQwkRIdEbl9%2bunV6BOnHa81DgZYY%3d&docid=0d31a1efcc9cf476c9cd3922f7b3a04fa&rev=1",
        "https://jbiet-my.sharepoint.com/personal/acm_jbiet_edu_in/_layouts/15/guestaccess.aspx?guestaccesstoken=00ZKG7Sg1Uk6f5%2bJ8v%2f%2b3a5ikFMmprb7Jmqp7HZpRRg%3d&docid=0dbe989f8917544878dfd7af6d0f2b1f3&rev=1",
        "https://jbiet-my.sharepoint.com/personal/infoquest_jbiet_edu_in/_layouts/15/guestaccess.aspx?docid=0b43779bcb8e5486b9d2610ddbd982e56&authkey=AYGnyb_JT-lUjsO4Im4OU_Q"]
    let identifurls = ["featured","other","sponsors","team"]
    let fidentiurls = ["hack","paper","codejam","gaming"]
    let oidentiurls = ["techmaze","quizzard","backtrack","googled"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = str
        
        
        
        if str == "sponsors" {
            let re = CGRect(x: tableView.bounds.width / 2, y: 0.0, width: 30, height: 30)
            let activityIndicatorView = UIActivityIndicatorView(frame: re)
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            let headerView: UIView = UIView(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: tableView.bounds.height))
            activityIndicatorView.activityIndicatorViewStyle = .gray
            activityIndicatorView.startAnimating()
            headerView.addSubview(activityIndicatorView)
            self.tableView.tableHeaderView = headerView
            self.tableView.isScrollEnabled = false
            Alamofire.request("https://jbgroup.org.in/sync/sync_mapp/iq_php/sponsors.php").responseJSON {
                response in
                
                let json = JSON(response.result.value)
                for det in json {
                    
                    
                    self.sponsordets.append(det.1["SponsorImage"].stringValue)
                }
                self.tableView.reloadData()
                self.tableView.tableHeaderView = nil
                self.tableView.isScrollEnabled = true
                
            }
            self.tableView.reloadData()
           
            
            self.tableView.separatorStyle = .none
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (str == "featured"){
            return furls.count
        }
        else if (str == "other"){
            return otherurls.count
        }
        
        else{
            return sponsordets.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        
        switch(str){
        case identifurls[0]:
            
            cell.imgview.sd_setImage(with: URL(string :furls[indexPath.row]))
            
            break
        case identifurls[1]:
            
            cell.imgview.sd_setImage(with: URL(string :otherurls[indexPath.row]))
            
            break
        case identifurls[2]:
            
            cell.imgview.sd_setImage(with: URL(string :sponsordets[indexPath.row]))
            
            break
            
        default:
            break
        }

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        if str == "featured"{
            if fidentiurls[indexPath.row] == "gaming" {
                performSegue(withIdentifier: "gaming", sender: self)
            }
                
                
            else if fidentiurls[indexPath.row] == "paper"{
                if defaults.value(forKey: "Key") != nil{
                    performSegue(withIdentifier: "paper", sender: self)
                }
                else {
                    performSegue(withIdentifier: "showdata", sender: self)
                }
            }
                
                
                
            else {
                performSegue(withIdentifier: "showdata", sender: self)
            }
        }
        else if str == "other"{
            performSegue(withIdentifier: "showdata", sender: self)
        }
        else {
            
        }
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if str == "featured"{
            
            switch(index){
            case 0:
                let vc = segue.destination as! TableViewControllerStatic
                vc.seguedata = "Hack@IQ"
                break
            case 1:
                if defaults.value(forKey: "Key") != nil {
                    let vc = segue.destination as! PaperTableViewController
                    vc.seguedata = "PaperPresentation"
                }
                else {
                    let vc = segue.destination as! TableViewControllerStatic
                    vc.seguedata = "PaperPresentation"
                }
                
                break
            case 2:
                let vc = segue.destination as! TableViewControllerStatic
                vc.seguedata = "Code JAM"
                break
           /* case 3:
                let vc = segue.destination as! TableViewControllerStatic
                vc.seguedata = "Gears of Rampage"
                break */
         /*   case 4:
                vc.seguedata = "Gaming"
                break */
            default:
                break
            }
        }
        else {
            switch index {
            case 0:
            let vc = segue.destination as! TableViewControllerStatic
            vc.seguedata = "Tech Maze"
            break
            case 1:
            let vc = segue.destination as! TableViewControllerStatic
            vc.seguedata = "Quizzard"
            break
            case 2:
            let vc = segue.destination as! TableViewControllerStatic
            vc.seguedata = "BackTrack"
            break
            case 3:
            let vc = segue.destination as! TableViewControllerStatic
            vc.seguedata = "Googled"
            break
            case 4:
                let vc = segue.destination as! TableViewControllerStatic
                vc.seguedata = "Can you C"
                break
            default:
                break
                
            
            
        }
        }
    }
    

}
