//
//  WelcomeViewController.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/11/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController{
    
    //Contents
    @IBOutlet var Logo: UIImageView!
    @IBOutlet var Welcome: UILabel!
    @IBOutlet var Description: UITextView!
    @IBOutlet var Next: UIButton!
    
    //Clouds
    @IBOutlet var cloudOne: CloudView!
    @IBOutlet var cloudTwo: CloudView!
    @IBOutlet var cloudThree: CloudView!
    
    
    //user Deafults Class
    let userDeafults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide Statues Bar
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Slide)
        
        //Welcome, Description, Next Initial
        self.Welcome.alpha = 0
        self.Description.alpha = 0
        self.Next.alpha = 0
        
        //Logo Initial
        self.Logo.alpha = 0
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        userDeafults.setBool(true, forKey: "firstTimeAppRun")
        
        
        /*===========================================
        * TUTORIAL INIT PAGE
        ============================================*/
        //Logo Animation
        UIView.animateWithDuration(0.7,delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.Logo.frame.offsetInPlace(dx: 0, dy: 269)
            self.Logo.alpha = 1
            }, completion: {
                (finished) -> Void in
                //Welcome, Description,  Next Animation
                UIView.animateWithDuration(0.7, delay: 0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                    self.Welcome.alpha = 1
                    }, completion: {
                        (finished)-> Void in
                        UIView.animateWithDuration(0.9, delay: 0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                             self.Description.alpha = 1
                            }, completion: {
                                (finished)-> Void in
                                UIView.animateWithDuration(1.1, delay: 0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                                    self.Next.alpha = 1
                                    }, completion: nil)
                        })
                })
        })
        
        self.cloudAnimation()
    }
    
    
    /*===========================================
    * CLOUDS
    ============================================*/
    func cloudAnimation(){
        //Animate Clouds
        UIView.animateWithDuration(15, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.cloudOne.frame.origin.x = self.view.frame.width / CGFloat(arc4random() % 3)
            self.cloudTwo.frame.origin.x = self.view.frame.width / -CGFloat(arc4random() % 5)
            self.cloudThree.frame.origin.x = self.view.frame.width / CGFloat(arc4random() % 7)
            
            //Fade In When Animcation Finished
            self.cloudOne.alpha = 0
            self.cloudTwo.alpha = 0
            self.cloudThree.alpha = 0
            
            }, completion: {
                (finished) -> Void in
                //Reset Fade In When Animcation Finished
                UIView.animateWithDuration(5, animations: {
                    self.cloudOne.frame.origin.x = self.view.frame.width / -CGFloat(arc4random() % 4)
                    self.cloudTwo.frame.origin.x = self.view.frame.width / CGFloat(arc4random() % 6)
                    self.cloudThree.frame.origin.x = self.view.frame.width / CGFloat(arc4random() % 2)
                    
                    self.cloudOne.alpha = 1
                    self.cloudTwo.alpha = 1
                    self.cloudThree.alpha = 1
                    }, completion: {
                        (finished) -> Void in
                        self.cloudAnimation()
                })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
