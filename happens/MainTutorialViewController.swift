//
//  MainTutorialViewController.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/12/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class MainTutorialViewController: UIViewController, UIPageViewControllerDataSource {
    
    //Tutorial Init
    var tutorialViewController: UIPageViewController!
    var tutorialTitle: NSArray!
    var tutorialNotice: NSArray!
    var tutorialImage: NSArray!
    var tutorialDescription: NSArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tutorialTitle = NSArray(objects: "Feed", "Compose", "Self-Indicator")
        self.tutorialNotice = NSArray(objects: "Vote, comment and get ranked.", "Write texts or share photos.", "Indicate which post, comments are users with self-indicator.")
        self.tutorialImage = NSArray(objects: "Feed", "Compose", "Self-Indicator")
        
        self.tutorialViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TutorialViewController") as! UIPageViewController
        
        self.tutorialViewController.dataSource = self
        
        let startVC = self.ViewControllerAtIndex(0) as TutorialViewController
        let viewController = NSArray(object: startVC)
        
        self.tutorialViewController.setViewControllers(viewController as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.tutorialViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.height - 30)
        
        self.addChildViewController(self.tutorialViewController)
        self.view.addSubview(self.tutorialViewController.view)
        self.tutorialViewController.didMoveToParentViewController(self)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*===========================================
    * TUTOTIAL CONTROLLER METHODS
    ============================================*/
    
    
    func ViewControllerAtIndex(index: Int) -> TutorialViewController{
        if self.tutorialTitle.count == 0 || index >= self.tutorialTitle.count {
            return TutorialViewController()
        }
        
        let VC: TutorialViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentTutorialController") as! TutorialViewController
        
        VC.tutorialImageFile = tutorialImage[index] as! String
        VC.tutorialNoticeText = tutorialNotice[index] as! String
        VC.tutorialTitleText = tutorialTitle[index] as! String
        VC.tutorialIndex = index
        
        return VC
        
    }
    
    //PAGE VIEW CONTROLLER DATASOURCE
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! TutorialViewController
        var index = vc.tutorialIndex as Int
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        index--
        return self.ViewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! TutorialViewController
        var index = vc.tutorialIndex as Int
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        if index == self.tutorialTitle.count {
            return nil
        }
        
        return self.ViewControllerAtIndex(index)
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.tutorialTitle.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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
