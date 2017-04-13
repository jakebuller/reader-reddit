//
//  Posts.swift
//  RedditReader
//
//  Created by Patrick West on 2017-04-13.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import Foundation

class Post {
    var title: String = ""
    var description: String = ""
    var author: String = ""
    var commentCount: Int = 0
    var createdAt: Date = Date()
    var permaLink: String = ""
    var imageUrl: String = ""
    
    var isSelf: Bool = false
    
    var comments: Array<Comment> = []
}
