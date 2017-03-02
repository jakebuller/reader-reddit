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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let subReddit = searchInput.text
        
//        if segue.identifier == "MySegueId"{
            if let nextViewController = segue.destination as? RedditPostsTableViewController{
                nextViewController.subReddit = subReddit! //Or pass any values
            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.w
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

