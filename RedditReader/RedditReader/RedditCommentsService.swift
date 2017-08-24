//
//  RedditCommentsService.swift
//  RedditReader
//
//  Created by Patrick West on 2017-08-24.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RedditCommentsService {
    func get(post: Post, completion: @escaping (_ result: Array<Comment>) -> Void) {
        var url = Constants.RedditApi.baseUrl + post.permaLink + Constants.RedditApi.jsonApiExt
        
        Alamofire.request(url).responseJSON { response in
            var comments = Array<Comment>()
            if (response.result.value != nil) {
                let listings = JSON(response.result.value!)
                
                for (_,subJson) in listings {
                    for (_, comment) in subJson["data"]["children"] {
                        if (comment["kind"].string == "t1") {
                            let commentObj = Comment()
                            commentObj.author = comment["data"]["author"].string!
                            commentObj.body = comment["data"]["body"].string!
                            comments.append(commentObj)
                        }
                    }
                }
            }
            
            post.comments.append(contentsOf: comments)
            completion(post.comments)
        }
        
    }
}
