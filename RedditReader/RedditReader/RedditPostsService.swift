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
        var postsUrl = Constants.RedditApi.baseUrl + subreddit.url
        if (subreddit.sortOrder != "") {
            postsUrl += subreddit.sortOrder + "/"
        }

        postsUrl += Constants.RedditApi.jsonApiExt

        print(postsUrl)
        
        if subreddit.filter != "" {
            postsUrl = Constants.RedditApi.baseUrl + subreddit.url + "search.json?q=" + subreddit.filter + "&restrict_sr=on"
        }
        
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
                        post.linkUrl = postJson["url"].string!
                        post.name = postJson["name"].string!
                    
                        // TODO: Refactor to check for availability of appropriate resolution images
                        if let sourceImg = postJson["preview"]["images"][0]["source"]["url"].string {
                            post.sourceImg = sourceImg
                        }
//                        post.sourceImg = postJson["preview"]["images"]["source"]["url"].string!

                    posts.append(post)
                }
            }

            subreddit.posts.append(contentsOf: posts)
            completion(posts)
        }
    }
}
