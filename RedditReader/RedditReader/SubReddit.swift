//
//  SubReddit.swift
//  RedditReader
//
//  Created by Patrick West on 2017-04-13.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import Foundation
import UIKit

class SubReddit {
    var name: String = ""
    var subscribers: Int = 0
    var description: String = ""
    var url: String = ""
    var imageUrl: String = ""
    var image: UIImage = UIImage(named: "list-thumbnail")!
    var posts = [Post]();
    
    func loadPosts(completion: @escaping (_ result: Array<Post>) -> Void) {
        RedditPostsService().get(subreddit: self, completion: completion)
    }
}
