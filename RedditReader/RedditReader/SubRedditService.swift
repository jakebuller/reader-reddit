//
//  SubRedditService.swift
//  RedditReader
//
//  Created by Jake Buller on 2017-04-20.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Kingfisher

class SubRedditService {
    func get(subreddit: String = "", completion: @escaping (_ result: SubReddit) -> Void) {
        let subRedditUrl = "http://reddit.com/r/" + subreddit + "/about.json"
        Alamofire.request(subRedditUrl).responseJSON { response in
            let subreddit = SubReddit()
            
            if (response.result.value != nil) {
                let subData = JSON(response.result.value!)["data"]
                subreddit.name = subData["display_name"].string!
                subreddit.description = subData["description"].string!
                subreddit.subscribers = subData["subscribers"].int!
                subreddit.url = subData["url"].string!
                subreddit.imageUrl = subData["icon_img"].string!
            }
            
            completion(subreddit)
        }
    }
    
    func search(searchTerm: String, completion: @escaping (_ result: Array<SubReddit>) -> Void) {
        let searchUrl = "https://www.reddit.com/subreddits/search.json?q=\(searchTerm)"
        
        Alamofire.request(searchUrl).responseJSON { response in
            var subreddits = Array<SubReddit>()
            
            if (response.result.value != nil) {
                let listings = JSON(response.result.value!)["data"]["children"]
                
                for (_,obj) in listings {
                    let subData = obj["data"]
                    let subreddit = SubReddit()
                    
                    subreddit.name = subData["display_name"].string!
                    
                    if let description = subData["description"].string {
                        subreddit.description = description
                    }
//                    subreddit.description = subData["description"].string!
                    if let subscribers = subData["subscribers"].int {
                        subreddit.subscribers = subscribers
                    }
//                    subreddit.subscribers = subData["subscribers"].int!
                    subreddit.url = subData["url"].string!
                    
                    if let imageUrl = subData["icon_img"].string {
                        subreddit.imageUrl = imageUrl
                    }
//                    subreddit.imageUrl = subData["icon_img"].string!
                    
//                    if (subData["icon_img"].string!.range(of: "http") != nil) {
//                        let url = URL(string: subData["icon_img"].string!)
//                        subreddit.image.kf.setImage(with: url)
//                    }
                  
                    subreddits.append(subreddit)
                }
                
            }
            
            completion(subreddits)
        }
    }
}

