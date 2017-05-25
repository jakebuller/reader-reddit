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
//        self.cardContainer.layer.borderWidth = 1
//        self.cardContainer.layer.borderColor = UIColor(red:0.36, green:0.36, blue:0.36, alpha:1.0).cgColor
        
//        let borderHeight = CGFloat(1.0)
//        
//        let border = CALayer()
//        border.frame = CGRect(x: 0, y: 0, width: self.postInfoContainer.frame.width, height: borderHeight)
//        border.borderWidth = borderHeight
//    
//        border.borderColor = UIColor(red:0.36, green:0.36, blue:0.36, alpha:1.0).cgColor
//        self.postInfoContainer.layer.addSublayer(border)
        
        
        // Add a white border to the top and bottom of each cell
//        let cellBorderHeight = CGFloat(10.0)
//        
//        let cellBorder = CALayer()
//        cellBorder.frame = CGRect(x: 0, y: self.frame.height - cellBorderHeight, width: self.frame.width, height: cellBorderHeight)
//        cellBorder.borderWidth = cellBorderHeight
//        
//        cellBorder.borderColor = UIColor.white.cgColor
//        self.layer.addSublayer(cellBorder)
    }
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
//        
//        var border = CALayer()
//        
//        switch edge {
//        case UIRectEdge.top:
//            
//            break
//        case UIRectEdge.bottom:
//            border.frame = CGRect(x: 0 y: self.frame.height - thickness, .width, thickness)
//            break
//        case UIRectEdge.left:
//            border.frame = CGRect(0, 0, thickness, self.frame.height)
//            break
//        case UIRectEdge.right:
//            border.frame = CGRect(self.frame.width - thickness, 0, thickness, self.frame.width)
//            break
//        default:
//            break
//        }
        
    }

    
}
