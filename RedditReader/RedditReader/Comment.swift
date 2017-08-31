//
//  Comment.swift
//  RedditReader
//
//  Created by Patrick West on 2017-04-13.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import Foundation


class Comment {
    var body: String = ""
    var author: String = ""
    var children: Array<Comment> = []
}
