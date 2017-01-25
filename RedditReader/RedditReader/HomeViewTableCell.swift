//
//  HomeViewTableCellTableViewCell.swift
//  RedditReader
//
//  Created by Jake Buller on 2017-01-24.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import UIKit

class HomeViewTableCell: UITableViewCell {
    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var cellDescription: UILabel!
    @IBOutlet var cellImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
