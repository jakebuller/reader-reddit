//
//  RefreshableUITableViewDelegate.swift
//  RedditReader
//
//  Created by Patrick West on 2017-08-17.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import Foundation
import UIKit


protocol RefreshableUITableViewDelegate : class {
    func tableViewDidRefresh(_ sender: UIRefreshControl)
}
