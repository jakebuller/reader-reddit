//
//  ViewController.swift
//  RedditReader
//
//  Created by Jake Buller on 2017-01-24.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var redditData: UITextView!
    
    @IBOutlet var searchInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func searchButtonClick(_ sender: Any) {
        NSLog("search clicked")
        NSLog(searchInput.text!)
        
        loadWebView(url: "http://google.ca")
        //getSearchData()
    }
    
    func loadWebView(url:String) {
        let newView = WebviewViewController(nibName: "WebviewViewController", bundle: nil)
        newView.urlstring = url
        newView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(newView, animated: true, completion: nil)
    }
    
    func getSearchData() {
        let searchTerm = searchInput.text!
        let searchUrl = "https://www.reddit.com/r/\(searchTerm)/.json"
        
        Alamofire.request(searchUrl).responseJSON { response in
            print(String(describing: response.request))  // original URL request
            print(String(describing: response.response)) // HTTP URL response
            print(String(describing: response.data))     // server data
            print(String(describing: response.result))   // result of response serialization
            
            if let JSON = response.result.value {
                self.redditData.text = String(describing: JSON)
            }
        }
    }
}

