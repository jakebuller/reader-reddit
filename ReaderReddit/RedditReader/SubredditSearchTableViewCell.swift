//
//  SubredditSearchTableViewCell.swift
//  RedditReader
//
//  Created by Patrick West on 2017-03-07.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import UIKit

class SubredditSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var subredditSubscriberCount: UILabel!
    @IBOutlet weak var subredditTitle: UILabel!
    @IBOutlet weak var subredditDescription: UILabel!
    @IBOutlet weak var subredditImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        self.cardContainer.layer.cornerRadius = 5
    }

}
