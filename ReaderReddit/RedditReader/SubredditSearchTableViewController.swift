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

class SubredditSearchTableViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var subredditList = [SubReddit]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    var searchBar : UISearchBar?
    
    var animation = LoadingIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.navigationTitle.titleView = self.getSearchBar()
        animation.initActivityIndicator(view: self.tableView)
        animation.startActivityAnimation()
        loadTrendingSubreddits()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.subredditList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubredditCell", for: indexPath) as! SubredditSearchTableViewCell
        let subReddit = self.subredditList[indexPath.row]
        
        cell.subredditTitle.text = subReddit.name
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
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
    
}
