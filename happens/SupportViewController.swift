//
//  HelpViewController.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/4/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit
import Alamofire

class SupportViewController: UIViewController, UIWebViewDelegate {
    
    
    //Outlets
    @IBOutlet var CoverView: UIVisualEffectView!
    @IBOutlet var legalView: UIView!
    @IBOutlet var legalViewTitle: UILabel!
    @IBOutlet var legalViewDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Legal View Settings
        self.legalViewSettings()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*****************************************************************
    * LEGAL VIEW
    *****************************************************************/
    
    @IBOutlet var legalWebView: UIWebView!
    
    @IBOutlet var legalProgressView: UIProgressView!
    var legalWebViewTimer: NSTimer!
    var legalWebViewBool: Bool!
    
    //Legal View Settings
    func legalViewSettings(){
        
        //Legal Web View Delegate
        self.legalWebView.delegate = self
        
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            //Hide Legal View Initially
            self.legalView.hidden = true
            self.legalView.alpha = 0
            self.legalView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0)
            
            //Legal View Inital Setting
            self.legalView.layer.shadowColor = UIColor.blackColor().CGColor
            self.legalView.layer.shadowOpacity = 0.3
            self.legalView.layer.shadowRadius = 15.0
            self.legalView.layer.shadowOffset = CGSizeMake(0, 2.0)
            self.legalView.layer.masksToBounds = false
        }
    }
    
    //Load Privacy Policy View in Legal View
    @IBAction func showPrivacyPolicy(sender: AnyObject) {
        //Update UI View with Privacy Policy Text and View
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            //Show Cover View
            self.CoverView.hidden = false
            
            //Change Legal Title
            self.legalViewTitle.text = "Privacy Policy"
            
            //Change Legal View to Privacy Policy
            let requestURL: NSURL = NSURL(string: "http://thehappens.com/legal/PP")!
            let request: NSURLRequest = NSURLRequest(URL: requestURL)
            self.legalWebView.loadRequest(request)
            
            //Bring Legal View to Appearance
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.legalView.hidden = false
                self.legalView.alpha = 1
                self.legalView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
                }, completion: nil)
        }
    }
    
    //Load Term of Use View in Legal View
    @IBAction func showTermOfUse(sender: AnyObject) {
        //Update UI View with Term of Use Text and View
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            //Show Cover View
            self.CoverView.hidden = false
            
            //Change Legal Title
            self.legalViewTitle.text = "Term of Use"
            
            //Change Legal View to Privacy Policy
            let requestURL: NSURL = NSURL(string: "http://thehappens.com/legal/TOU")!
            let request: NSURLRequest = NSURLRequest(URL: requestURL)
            self.legalWebView.loadRequest(request)
            
            
            //Bring Legal View to Appearance
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.legalView.hidden = false
                self.legalView.alpha = 1
                self.legalView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
                }, completion: nil)
        }
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.legalProgressView.progress = 0
        }
        legalWebViewBool = false
        legalWebViewTimer = NSTimer.scheduledTimerWithTimeInterval(0.01667, target: self, selector: "updateLegalWebViewProgress", userInfo: nil, repeats: true)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        legalWebViewBool = true
    }
    
    func updateLegalWebViewProgress(){
        if legalWebViewBool == true {
            if legalProgressView.progress >= 1 {
                legalProgressView.hidden = true
                legalWebViewTimer.invalidate()
            }else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    UIView.animateWithDuration(0.3, animations: {
                        self.legalProgressView.progress += 0.1
                    })
                })
            }
        } else {
            legalProgressView.progress += 0.05
            if legalProgressView.progress >= 0.95{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    UIView.animateWithDuration(0.3, animations: {
                        self.legalProgressView.progress = 0.95
                    })
                })
            }
        }
    }
    
    //Exit Legal View
    @IBAction func exitLegalView(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            //Reset Legal View Text
            self.legalViewTitle.text = "Legal"
            //Empty Web View
            let requestURL: NSURL = NSURL(string: "about:blank")!
            let request: NSURLRequest = NSURLRequest(URL: requestURL)
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.legalWebViewBool = false
                self.legalProgressView.progress = 0
                self.legalProgressView.hidden = false
            }
            
            self.legalWebView.loadRequest(request)
            //Hide Legal View
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                //Hide Legal View
                self.legalView.alpha = 0
                self.legalView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0)
                }, completion: {
                    (finished)-> Void in
                    self.CoverView.hidden = true
                    self.legalView.hidden = true
            })
        }
    }
    
    
    /*****************************************************************
    * WEB SEGUE
    *****************************************************************/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //If Segue is Blog Pass Blog URL PATH
        if segue.identifier == "toWebBlog" {
            let ExchangeViewData = segue.destinationViewController as! WebViewController
            ExchangeViewData.URLPATH = "http://blog.thehappens.com"
            ExchangeViewData.currentTitle = "Blog"
        }
        
        
        //If Segue is Support Pass Support URL PATH
        if segue.identifier == "toWebSupport" {
            let ExchangeViewData = segue.destinationViewController as! WebViewController
            ExchangeViewData.URLPATH = "http://support.thehappens.com"
            ExchangeViewData.currentTitle = "Support"
        }
        
    }
}
