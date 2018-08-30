//
//  TutorialViewController.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/12/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    //Initialization
    @IBOutlet var tutorialTitle: UILabel!
    @IBOutlet var tutorialNotice: UILabel!
    @IBOutlet var tutorialImage: UIImageView!
    
    var tutorialIndex: Int!
    var tutorialTitleText: String!
    var tutorialNoticeText: String!
    var tutorialImageFile: String!
    
    //user Deafults Class
    let userDeafults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tutorialTitle.text = self.tutorialTitleText
        self.tutorialNotice.text = self.tutorialNoticeText
        self.tutorialImage.image = UIImage(named: self.tutorialImageFile)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitTutorial(sender: AnyObject) {
        self.userDeafults.setBool(true, forKey: "firstTimeAppRun")
        self.userDeafults.synchronize()
        self.performSegueWithIdentifier("toAuthFromTutorial", sender: self)
        
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
