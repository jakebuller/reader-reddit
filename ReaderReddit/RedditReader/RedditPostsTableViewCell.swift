//
//  HomeViewTableCellTableViewCell.swift
//  RedditReader
//
//  Created by Jake Buller on 2017-01-24.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import UIKit

class RedditPostsTableViewCell: UITableViewCell {
    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var cellPostDate: UILabel!
    @IBOutlet var cellPostAuthor: UILabel!
    @IBOutlet var cellPostComments: UILabel!
    
    @IBOutlet var titleViewContainer: UIView!
    @IBOutlet var postInfoContainer: UIView!
    @IBOutlet var cardContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        self.cardContainer.layer.cornerRadius = 5
    }
}
