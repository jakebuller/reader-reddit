//
//  ActivityAnimation.swift
//  RedditReader
//
//  Created by Patrick West on 2017-07-20.
//  Copyright © 2017 Jake Buller. All rights reserved.
//


import UIKit

class LoadingIndicator {
    
    var indicator = UIActivityIndicatorView()
    
    public func initActivityIndicator(view: UIView) {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = CGPoint(x: view.center.x, y: view.center.y - 40)
        view.addSubview(indicator)
    }
    
    public func startActivityAnimation()
    {
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
    }
    
    public func stopActivityAnimation()
    {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
}
