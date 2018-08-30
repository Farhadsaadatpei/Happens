//
//  WebViewController.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/20/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    //Outlets
    
    @IBOutlet var webView: UIWebView!
    
    //URL Path and Name
    var URLPATH: String!
    var currentTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
                
        //View Title and Hide Back Button text
        self.navigationItem.title = currentTitle
        self.navigationController?.navigationBar.topItem!.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        //Load URL Path in Web View
        let requestURL: NSURL = NSURL(string: URLPATH)!
        let request: NSURLRequest = NSURLRequest(URL: requestURL)
        self.webView.loadRequest(request)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
