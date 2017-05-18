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
    var sortType = Constants.SortType.Hot;
    var subReddit = String();
    
    func get(subreddit: SubReddit, after: Post? = nil, completion: @escaping (_ result: Array<Post>) -> Void) {
        var postsUrl = "http://reddit.com/" + subreddit.url + ".json"

        if (after != nil) {
            postsUrl += "?after=" + after!.name
        }
        
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
                        post.name = postJson["name"].string!

                    posts.append(post)
                }
            }

            subreddit.posts.append(contentsOf: posts)
            completion(posts)
        }
    }
}
