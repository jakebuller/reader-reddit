//
//  RedditPostsService.swift
//  RedditReader
//
//  Created by Jake Buller on 2017-04-13.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import Foundation
import Alamofire

class RedditPostsService {
    
    var posts = [NSDictionary]();
    var sortType = "hot";
    var subReddit = String();
    
    func getPosts(after: String = "") -> Array<NSDictionary> {
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
