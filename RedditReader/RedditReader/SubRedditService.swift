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
        let subRedditUrl = "http://reddit.com/r/" + subreddit + "/about.json"
        Alamofire.request(subRedditUrl).responseJSON { response in
            var subreddit = SubReddit()
            
            if let json = response.result.value {
                let subData = JSON(response.result.value!)["data"]
                subreddit.name = subData["display_name"].string!
                subreddit.description = subData["description"].string!
                subreddit.subscribers = subData["subscribers"].int!
                subreddit.url = subData["url"].string!
                subreddit.imageUrl = subData["icon_img"].string!
            }
            
            completion(subreddit)
//            NotificationCenter.default.post(name: Notification.Name("postsLoaded"), object: nil, userInfo: ["posts": self.posts])
        }
    }
}

