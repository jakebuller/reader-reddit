//
//  RedditPostsService.swift
//  RedditReader
//
//  Created by Jake Buller on 2017-04-13.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RedditPostsService {
    
    var posts = [NSDictionary]();
    var sortType = "hot";
    var subReddit = String();
    
    func get(subreddit: SubReddit, completion: @escaping (_ result: Array<Post>) -> Void) {
        let postsUrl = "http://reddit.com/" + subreddit.url + ".json"

        Alamofire.request(postsUrl).responseJSON { response in
            var posts = Array<Post>()

            if (response.result.value != nil) {
                let postsJson = JSON(response.result.value!)["data"]["children"]

                for (_,obj) in postsJson {
                    let postJson = obj["data"]
                        let post = Post()
                        post.author = postJson["author"].string!
                        post.commentCount = postJson["num_comments"].int!
                        post.createdAt = Date(timeIntervalSince1970: TimeInterval(postJson["created"].int!))
                        post.title = postJson["title"].string!
                        post.isSelf = postJson["is_self"].bool!
                        post.imageUrl = postJson["thumbnail"].string!
                        post.permaLink = postJson["permalink"].string!

                    posts.append(post)
                }
            }

            completion(posts)
        }
    }

    func getPosts(after: String = "", sortType: String = "") -> Array<NSDictionary> {
        // Remove all posts held in memory if the sort type has changed
        if (self.sortType != sortType) {
            self.sortType = sortType
            self.posts.removeAll()
        }

        self.loadPosts()
        return self.posts
    }
    
    private func loadPosts(after: String = "") {
        var searchUrl = String();
        if (subReddit.isEmpty) {
            searchUrl = "https://www.reddit.com/" + sortType + "/.json?"
        } else {
            searchUrl = "https://www.reddit.com/r/" + subReddit + "/" + sortType + "/.json?"
        }
        
        if (!self.posts.isEmpty) {
            searchUrl += "count=" + String(self.posts.count)
        }
        
        if (!after.isEmpty) {
            searchUrl += "&after=" + after
        }
        
        Alamofire.request(searchUrl).responseJSON { response in
            if let json = response.result.value {
                let obj = json as! NSDictionary
                let data = obj["data"] as! NSDictionary
                let children = data["children"] as! NSArray
                let childrenArray = children as! Array<NSDictionary>
                self.posts.append(contentsOf: childrenArray)
            }

            
            NotificationCenter.default.post(name: Notification.Name("postsLoaded"), object: nil, userInfo: ["posts": self.posts])
        }
    }
}
