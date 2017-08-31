//
//  RefreshableUITableView.swift
//  RedditReader
//
//  Created by Patrick West on 2017-08-17.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import Foundation
import UIKit

class RefreshableUITableView: UITableView {
    
    var pullRefreshControl = UIRefreshControl()
    weak var refreshDelegate: RefreshableUITableViewDelegate?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.pullRefreshControl.addTarget(self,
                                          action: #selector(refreshOptions(sender:)),
                                          for: .valueChanged)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.pullRefreshControl.addTarget(self,
                                          action: #selector(refreshOptions(sender:)),
                                          for: .valueChanged)
        
        self.refreshControl = self.pullRefreshControl
        
        self.pullRefreshControl.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
    }
    
    func refreshOptions(sender: UIRefreshControl) {
        self.refreshDelegate?.tableViewDidRefresh(sender)
    }
    
    func endRefreshing() {
        self.pullRefreshControl.endRefreshing()
    }
    
    func isRefreshing() -> Bool {
        return self.pullRefreshControl.isRefreshing
    }
}
