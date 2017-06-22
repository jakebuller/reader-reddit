//
//  HomeViewController.swift
//  
//
//  Created by Jake Buller on 2017-01-24.
//
//

import UIKit
import Alamofire
import Kingfisher

class RedditPostsTableViewController: UITableViewController {

    @IBOutlet var sortTypeControl: UISegmentedControl!

    var subreddit = SubReddit()
    var sortType = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        let subRedditService = SubRedditService()
        if (self.subreddit.name.isEmpty) {
            subRedditService.get(subreddit: "politics", completion: self.subredditLoadedHandler)
        } else {
            self.subreddit.loadPosts(completion: self.postsLoaded)
        }
    }
    
    func subredditLoadedHandler(subreddit: SubReddit) { 
        self.subreddit = subreddit
        self.subreddit.loadPosts(completion: self.postsLoaded)
    }
    
    func postsLoaded(posts: Array<Post>) {
        self.tableView.reloadData()
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subreddit.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RedditPostsTableViewCell
        if (self.subreddit.posts.isEmpty) {
            return cell;
        }

        let post = self.subreddit.posts[indexPath.row]
        cell.cellTitle.text = post.title
        cell.cellPostAuthor.text = post.author
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        cell.cellPostDate.text = formatter.string(from: post.createdAt)
        

        let imgURL = post.imageUrl

        if imgURL.range(of:"http") != nil {
            let url = URL(string: imgURL)
            cell.cellImage.kf.setImage(with: url)
        } else {
            cell.cellImage.image = UIImage(named: "pepe")
        }

        // Start loading more posts when we are 3 away to make scrolling smoother
        if indexPath.row == self.subreddit.posts.count - 3 {
            let lastPost = self.subreddit.posts[self.subreddit.posts.count - 1]
            self.subreddit.loadPosts(after: lastPost, completion: self.postsLoaded)
        }

        return cell
    }
    
    func loadWebView(url:String) {
        let newView = WebviewViewController(nibName: "WebviewViewController", bundle: nil)
        newView.urlstring = url
        newView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(newView, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let post = self.subreddit.posts[selectedRow]
            
            if let nextViewController = segue.destination as? CommentsTableViewController{
                nextViewController.permalink = post.permaLink //Or pass any values
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
