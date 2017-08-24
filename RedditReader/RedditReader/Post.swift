//
//  Posts.swift
//  RedditReader
//
//  Created by Patrick West on 2017-04-13.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import Foundation

class Post : CustomStringConvertible{
    public var description: String { return self.toString() }

    var name: String = ""
    var title: String = ""
    var author: String = ""
    var commentCount: Int = 0
    var createdAt: Date = Date()
    var permaLink: String = ""
    var imageUrl: String = ""
    var linkUrl: String = ""
    var sourceImg: String = ""

    var isSelf: Bool = false

    var comments: Array<Comment> = []

    
    func clearComments() {
        self.comments = [Comment]();
    }
    
    func loadComments( completion: @escaping (_ result: Array<Comment>) -> Void) {
        RedditCommentsService().get(post: self, completion: completion)
    }
    
    func toString() -> String {
        return "Author: " + self.author + " title: " + self.title
    }
}
