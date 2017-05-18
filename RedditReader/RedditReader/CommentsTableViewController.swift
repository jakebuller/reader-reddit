//
//  CommentsTableViewController.swift
//  RedditReader
//
//  Created by Patrick West on 2017-03-21.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CommentsTableViewController: UITableViewController {

    
    var commentsList : Array<JSON> = Array();
    
    var permalink = String();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadComments()
    }
    
    func loadComments() {
        let url = "https://www.reddit.com/" + self.permalink + ".json"
        Alamofire.request(url).responseJSON { response in
            if (response.result.value != nil) {
                let listings = JSON(response.result.value!)
                
                for (_,subJson) in listings {
                    for (_, comment) in subJson["data"]["children"] {
                        if (comment["kind"].string == "t1") {
                            self.commentsList.append(comment["data"])
                        }
                    }
                }
            }
            self.tableView.reloadData()
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
        return self.commentsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentsTableViewCell

        let comment = self.commentsList[indexPath.row]
        
        cell.commentLabel.text = comment["body"].stringValue
        cell.authorLabel.text = comment["author"].stringValue
        
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
