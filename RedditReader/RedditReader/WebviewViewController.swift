//
//  WebviewViewController.swift
//  RedditReader
//
//  Created by Patrick West on 2017-01-24.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import UIKit

class WebviewViewController: UIViewController {
    @IBOutlet weak var webview: UIWebView!
    var urlstring = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let url = URL(string: urlstring)
        let request = URLRequest(url: url!)
        webview.loadRequest(request)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
