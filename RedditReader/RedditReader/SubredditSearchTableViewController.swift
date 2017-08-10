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

class SubredditSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var subredditList = [SubReddit]()
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    var searchBar : UISearchBar?
    
    var animation = LoadingIndicator()
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchTerm = searchBar.text!
        self.subredditList = []
        self.tableView.reloadData()
        
        animation.startActivityAnimation()
        if (searchTerm.isEmpty) {
            self.loadTrendingSubreddits()
        } else {
            SubRedditService().search(searchTerm: searchTerm, completion: self.subredditsLoaded)
        }
    }
    
    func getSearchBar() -> UISearchBar {
        guard (self.searchBar == nil) else {
            return self.searchBar!
        }
        self.searchBar = UISearchBar()
        
        self.searchBar!.delegate = self
        self.searchBar!.searchBarStyle = UISearchBarStyle.prominent
        self.searchBar!.placeholder = " Search..."
        self.searchBar!.sizeToFit()
        self.searchBar!.isTranslucent = false
        
        return self.searchBar!
    }
    
    func loadTrendingSubreddits() {
        SubRedditService().trending(completion: self.subredditsLoaded)
    }
    
    func subredditsLoaded(subReddits: Array<SubReddit>) {
        self.subredditList = subReddits
        self.tableView.reloadData()
        animation.stopActivityAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.navigationTitle.titleView = self.getSearchBar()
        animation.initActivityIndicator(view: self.tableView)
        animation.startActivityAnimation()

        loadTrendingSubreddits()
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
        let subReddit = self.subredditList[indexPath.row]
        
        cell.subredditTitle.text = subReddit.name
//        cell.subredditDescription.text = subReddit.description
//        cell.subredditSubscriberCount.text = String(describing: subReddit.subscribers)
        
        if (subReddit.imageUrl.range(of: "http") != nil) {
            let url = URL(string: subReddit.imageUrl)
            cell.subredditImage.kf.setImage(with: url)
        } else {
            cell.subredditImage.image = UIImage(named: "list-thumbnail")
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let selectedSubreddit = self.subredditList[selectedRow]

            if let nextViewController = segue.destination as? RedditPostsTableViewController{
                nextViewController.subreddit = selectedSubreddit //Or pass any values
            }
        }
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
