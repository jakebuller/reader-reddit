//
//  Constants.swift
//  RedditReader
//
//  Created by Jake Buller on 2017-05-10.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

struct Constants{
    struct SortType {
        static let New = "new"
        static let Hot = "hot"
        static let Controversial = "controversial"
        static let Rising = "rising"
    }

    struct RedditApi {
        static let baseUrl = "http://reddit.com/"
        static let jsonApiExt = ".json"
        static let subredditUri = "r/"
    }
}
