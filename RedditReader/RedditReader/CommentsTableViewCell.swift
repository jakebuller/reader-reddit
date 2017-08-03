//
//  CommentsTableViewCell.swift
//  RedditReader
//
//  Created by Patrick West on 2017-03-21.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet var cardContainer: UIView!
//    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentLabel: UITextView!
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
