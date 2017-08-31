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

class SubRedditService {
    func get(subreddit: String = "", completion: @escaping (_ result: SubReddit) -> Void) {
        let subRedditUrl = "http://reddit.com/" + subreddit + "/about.json"
        Alamofire.request(subRedditUrl).responseJSON { response in
            var subreddit = SubReddit()
            
            if (response.result.value != nil) {
                let subData = JSON(response.result.value!)["data"]
                subreddit = self.buildSubredditFromJson(jsonData: subData)
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
                    subreddits.append(self.buildSubredditFromJson(jsonData: obj["data"]))
                }
            }
            
            completion(subreddits)
        }
    }
    
    func trending(completion: @escaping (_ result: Array<SubReddit>) -> Void) {
        let url = "https://www.reddit.com/subreddits/.json"
        
        Alamofire.request(url).responseJSON { response in
            var subreddits = Array<SubReddit>()
            
            if (response.result.value != nil) {
                let listings = JSON(response.result.value!)["data"]["children"]
                
                for (_,obj) in listings {
                    subreddits.append(self.buildSubredditFromJson(jsonData: obj["data"]))
                }
            }
            
            completion(subreddits)
        }
    }
    
    private func buildSubredditFromJson(jsonData: JSON) -> SubReddit {
        let subreddit = SubReddit()
        
        if let displayName = jsonData["display_name"].string {
            subreddit.name = displayName
        }
        
        if let description = jsonData["description"].string {
            subreddit.description = description
        }
        if let subscribers = jsonData["subscribers"].int {
            subreddit.subscribers = subscribers
        }
        
        if let url = jsonData["url"].string {
            subreddit.url = url
        }
        
        if let imageUrl = jsonData["icon_img"].string {
            subreddit.imageUrl = imageUrl
        }
        
        return subreddit
    }
}

