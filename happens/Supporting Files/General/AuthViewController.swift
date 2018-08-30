//
//  AuthViewController.swift
//  happens
//
//  Created by Vilvas, Inc. on 7/10/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class AuthViewController: UIViewController, CLLocationManagerDelegate, NSFetchedResultsControllerDelegate {
    
    var locManager = CLLocationManager()
    
    @IBOutlet weak var AuthButton: UIButton!
    @IBOutlet weak var AuthText: UITextView!
    @IBOutlet weak var logo: UIImageView!
    
    //user Deafults Class
    let userDeafults = NSUserDefaults.standardUserDefaults()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Statues Bar to Light
        self.preferredStatusBarStyle()
        self.setNeedsStatusBarAppearanceUpdate()
        
        //Hide Statues Bar
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
        
        self.logo.alpha = 0
        
        UIView.animateWithDuration(0.5, animations: {
            self.logo.frame.offsetInPlace(dx: 0, dy: 60)
            self.logo.alpha = 0.2
            self.AuthText.alpha = 1
            }, completion: {(finished: Bool)-> Void in
                UIView.animateWithDuration(0.5, animations: {
                    self.logo.alpha = 1
                })
        })
        
        
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locManager.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        /*===========================================
        * FIRST TIME APP RUN
        ============================================*/
        let firstTimeAppRun: Bool! = userDeafults.boolForKey("firstTimeAppRun")
        if firstTimeAppRun == nil || firstTimeAppRun == false{
            self.performSegueWithIdentifier("firstTimeAppRun", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
         self.AuthButton.alpha = 1
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            
            //Update Location
            locManager.startUpdatingLocation()
            
            //Allow Location Action, Show Logo in Middle
            UIView.animateWithDuration(0.5, animations: {
                self.logo.frame.offsetInPlace(dx: 0, dy: 160)

                }, completion: {(finished: Bool)-> Void in
                    self.performSegueWithIdentifier("toTable", sender: self)
                }
            )
            
            self.AuthText.alpha = 0
            self.AuthButton.alpha = 0
        }
        
        if status == CLAuthorizationStatus.Denied {
            
            //Denied Message
            self.AuthText.alpha = 0
            UIView.animateWithDuration(1, animations: {
                self.AuthText.text = "You deny authorization, please go to setting -> Privacy -> Location Services and Authorize Happen to use location services."
                self.AuthText.font = UIFont(name: ".SFUIText-Regular", size: 14)
                self.AuthText.textColor = UIColor.whiteColor()
                self.AuthText.alpha = 1
                }, completion: {
                    (finished: Bool)-> Void in
                    UIView.animateWithDuration(0.3, animations: {
                        self.AuthButton.alpha = 0
                    })
            })
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locManager.stopUpdatingLocation()
    }
    
    
    @IBAction func UseLocation(sender: AnyObject) {
        locManager.requestWhenInUseAuthorization()
    }
    
}
