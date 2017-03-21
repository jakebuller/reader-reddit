//
//  SubredditSearchController.swift
//  RedditReader
//
//  Created by Patrick West on 2017-03-07.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class SubredditSearchTableViewController: UITableViewController {
    
    var subredditList: NSArray = NSArray();
    
    @IBOutlet weak var searchInput: UITextField!
    
    @IBAction func searchSubreddit(_ sender: Any) {
        let searchTerm = searchInput.text!
        let searchUrl = "https://www.reddit.com/subreddits/search.json?q=\(searchTerm)"
        
        if searchTerm.isEmpty {
            loadTrendingSubreddits()
            return
        }
        
        Alamofire.request(searchUrl).responseJSON { response in
            if let json = response.result.value {
                let obj = json as! NSDictionary
                if obj.object(forKey: "kind") != nil {
                    let data = obj["data"] as! NSDictionary
                    let children = data["children"] as! NSArray
                    self.subredditList = children
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func loadTrendingSubreddits() {
        let url = "https://www.reddit.com/subreddits/.json"
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value {
                let obj = json as! NSDictionary
                if obj.object(forKey: "kind") != nil {
                    let data = obj["data"] as! NSDictionary
                    let children = data["children"] as! NSArray
                    self.subredditList = children
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func decodeString(_ htmlEncodedString : String) -> String {
        guard let encodedData = htmlEncodedString.data(using: .utf8) else {
            return htmlEncodedString
        }
        
        let attributedOptions: [String : Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            return attributedString.string
        } catch {
            print("Error: \(error)")
            return htmlEncodedString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadTrendingSubreddits()
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
        return self.subredditList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubredditCell", for: indexPath) as! SubredditSearchTableViewCell
        let post = self.subredditList[indexPath.row] as! NSDictionary
        let postData = post["data"] as! NSDictionary
        cell.subredditTitle.text = postData["display_name"] as? String
        if let description = postData["public_description"] as? String {
            cell.subredditDescription.text = decodeString(description)
        } else {
            cell.subredditDescription.text = ""
        }
        if let imgURL = postData["icon_img"] as? String {
            if  imgURL.range(of:"http") != nil {
                let url = URL(string: imgURL)
                cell.subredditImage.kf.setImage(with: url)
            } else {
                cell.subredditImage.image = UIImage(named: "list-thumbnail")
            }
        } else {
            cell.subredditImage.image = UIImage(named: "list-thumbnail")
        }
        
        if let subscriberCount = postData["subscribers"] as? Int {
            cell.subredditSubscriberCount.text = String(describing: subscriberCount)
        } else {
            cell.subredditSubscriberCount.text = "?"
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let selectedSubreddit = self.subredditList[selectedRow] as! NSDictionary
            
            
            let postData = selectedSubreddit["data"] as! NSDictionary
            let subReddit = postData["display_name"] as? String
            
            
            if let nextViewController = segue.destination as? RedditPostsTableViewController{
                nextViewController.subReddit = subReddit! //Or pass any values
            }
        }
        
        //        if segue.identifier == "MySegueId"{

        //        }
    }
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let post = self.subredditList[indexPath.row] as! NSDictionary
//        let postData = post["data"] as! NSDictionary
//        let url_string = postData["url"] as! String
//        loadWebView(url: url_string)
//    }

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
