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
import SafariServices

class CommentsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RefreshableUITableViewDelegate {

    @IBOutlet var tableView: RefreshableUITableView!
    
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var postTitle: UILabel!
    @IBOutlet var postAuthor: UILabel!
    @IBOutlet var postTime: UILabel!
    
    var commentsList : Array<JSON> = Array();
    
    var permalink = String();
    var post = Post();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.delegate = self
        tableView.refreshDelegate = self
        tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 80
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(CommentsTableViewController.userTappedOnTitle))
        self.postTitle.isUserInteractionEnabled = true
        self.postTitle.addGestureRecognizer(gesture)

        layoutPostComponent()
        
        self.post.loadComments(completion: self.commentsLoaded)
    }

    func userTappedOnTitle()
    {
        let svc = SFSafariViewController(url: URL(string: self.post.linkUrl)!)
        self.present(svc, animated: true, completion: nil)
    }
    
    func tableViewDidRefresh(_ sender: UIRefreshControl) {
        if (self.tableView.isRefreshing()) {
            self.post.clearComments()
            self.tableView.reloadData()
            self.post.loadComments(completion: self.commentsLoaded)
        }
    }
    
    func commentsLoaded(comments: Array<Comment>)
    {
        self.tableView.endRefreshing()
        self.tableView.reloadData()
    }

    func layoutPostComponent()
    {
        self.postTitle.text = self.post.title
//        self.postAuthor.text = self.post.author
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm"
//        self.postTime.text = formatter.string(from: self.post.createdAt)
        
        if self.post.imageUrl.range(of:"http") != nil {
            let url = URL(string: self.post.imageUrl)
            self.postImage.kf.setImage(with: url)
        } else {
            self.postImage.image = UIImage(named: "pepe")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.post.comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentsTableViewCell

        let comment = self.post.comments[indexPath.row]
        
        cell.commentLabel.text = comment.body
        cell.authorLabel.text = comment.author
        
        return cell
    }
}
