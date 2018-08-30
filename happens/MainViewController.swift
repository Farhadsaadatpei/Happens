
//  MainViewController.swift
//  happens
//
//  Created by Vilvas, Inc. on 7/13/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import AVFoundation
// import Alamofire
// import SwiftKeychainWrapper
// import HidingNavigationBar
// import SDWebImage

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate , ComposeDelegate, NormalPostTableViewCellDelegate, CameraViewDelegate {
    
    //TITLE VIEW (Navigation Title View
    var titleView: UILabel!
    
    //HIDE/SHOW NAVIGATION
    var hidingNavBarManager: HidingNavigationBarManager?
    
    //TABLEVIEW
    @IBOutlet var tableView: UITableView!
    
    //COMPOSE VIEW
    @IBOutlet var composeView: Compose!
    @IBOutlet var AddPostButton: PostButton!
    
    //LOADING VIEW
    @IBOutlet var loadingView: UIView!
    
    //TOOLBAR VIEW
    @IBOutlet var bottomNavigation: UIView!
    
    //LOCATION INIT VALUE
    var longitude: Float = 0.0
    var latitude: Float = 0.0
    
    //LOCATION MANAGER CLASS
    var locManager = CLLocationManager()
    
    //USERID
    var USERID: String!
    
    //This Cover View is used when something require user attention
    @IBOutlet var coverView: UIVisualEffectView!
    
    /*****************************************************************
    * VIEWS
    *****************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //GET USER ID FROM KEYCHAIN
        USERID = KeychainWrapper.stringForKey("USERID")

        
        //CHANGE NAVIGATION TITLE
        let titleName: String = "Happening"
        let titleLabel: NSMutableAttributedString = NSMutableAttributedString(string: titleName)
        let titleAttribute = [ NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(15)]
        titleLabel.setAttributes(titleAttribute, range: NSMakeRange(0, titleName.characters.count))
        self.titleView = UILabel(frame: CGRectMake(0, 0, (self.navigationController?.navigationBar.frame.width)!, (self.navigationController?.navigationBar.frame.height)!))
        self.titleView.numberOfLines = 2
        self.titleView.textAlignment = NSTextAlignment.Center
        self.titleView.backgroundColor = UIColor.clearColor()
        self.titleView.font = UIFont.systemFontOfSize(12)
        self.titleView.textColor = UIColor.whiteColor()
        self.titleView.attributedText = titleLabel
        self.titleView.sizeToFit()
        self.navigationItem.titleView = titleView
        
        //SETTING BUTTON DISABLE
        menuButton.enabled = false
        
        //CELL OPTION VIEW
        self.OptionsDialog.hidden = true
        
        //COMPOSE VIEW
        self.composeView.hidden = true
        self.composeView.delegate = self
        self.composeView.PostTextField.delegate = self
        
        //Report Text View
        self.reportTextView.delegate = self
        
        //CAMERA VIEW
        self.Camera.delegate = self
        
        //LOCATION INIT
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.startUpdatingLocation()
        locManager.startMonitoringSignificantLocationChanges()
        
        //SHOW & HIDE NAVIGATION (Extension for Menu)
        hidingNavBarManager = HidingNavigationBarManager(viewController: self, scrollView: tableView)
        
        if let postBar = bottomNavigation { hidingNavBarManager?.manageBottomBar(postBar) }
        hidingNavBarManager?.refreshControl = refreshControl
        
        //REFRESH CONTROLLER SETUP
        self.setupRefreshControll()
        
        self.extensionViewSetup()
        
        //SETUP TABLE
        self.setupTable()
        
        //LOADING DATA
        DataManager.PostData = []
        self.currentItems = initialItems
        self.performLoadData()
        
        //LOADINGVIEW
        self.setupNoDataMessage()
        
        //Report View
        self.reportViewSetup()
        
        //CAMERA
        imagePicker.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hidingNavBarManager?.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hidingNavBarManager?.viewDidLayoutSubviews()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        hidingNavBarManager?.viewWillDisappear(animated)
    }
    
    /*****************************************************************
    * SETTING BUTTON
    *****************************************************************/
    @IBOutlet var menuButton: MenuButton!
    @IBAction func menuButton(sender: AnyObject) {
        //Setting Button Action
    }
    
    /*****************************************************************
     * Extension View
     *****************************************************************/
    
    @IBOutlet var extensionView: UIView!
     
    func extensionViewSetup(){
        self.extensionView.layer.shadowRadius = 2
        self.extensionView.layer.shadowOpacity = 0.4
        self.extensionView.layer.shadowOffset = CGSizeMake(0, 1)
        self.extensionView.layer.shadowColor = UIColor.lightGrayColor().CGColor
        
        self.extensionView.layer.masksToBounds = false
        
        //hidingNavBarManager?.addExtensionView(self.extensionView)
        
        //Search Bar
        self.searchBarSetup()
  
    }
    
    
    /*****************************************************************
     * Search Bar
     *****************************************************************/

    @IBOutlet var searchBar: UITextField!
    
    //Search Bar Settings
    func searchBarSetup(){
        
        self.searchBar.layer.cornerRadius = 5
        
        //Magnifier view
        let Magnifier = MagnifierView(frame: CGRectMake(0, 0, 25, 25))
        Magnifier.backgroundColor = UIColor.clearColor()
        Magnifier.DefaultColor = UIColor.lightGrayColor()
        
        self.searchBar.leftView = Magnifier
        self.searchBar.leftViewMode = UITextFieldViewMode.Always

    }
    
    /*****************************************************************
    * SCROLL
    *****************************************************************/
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        hidingNavBarManager?.shouldScrollToTop()
        return true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = self.tableView.contentOffset.y
        for cell in self.tableView.visibleCells as! [NormalPostTableViewCell] {
            if cell.postPhoto != nil {
                let x = cell.postPhoto.frame.origin.x
                let w = cell.postPhoto.bounds.width
                let h = cell.postPhoto.bounds.height
                let y = ((offsetY - cell.frame.origin.y) / h) * 45
                cell.postPhoto.frame = CGRectMake(x, y, w, h)
            }
        }
        
        if (scrollView.contentOffset.y > 1000) {
            self.scrollUpButton.enabled = true
            UIView.animateWithDuration(0.5) { () -> Void in
                self.scrollUpButton.alpha = 1
            }
        } else {
            self.scrollUpButton.enabled = false
            UIView.animateWithDuration(0.5) { () -> Void in
                self.scrollUpButton.alpha = 0
            }
        }
        
        /*****************************************************************
        * REFRESH CONTROL PULL ADJUSTMENT IN SCROLL ACTION
        *****************************************************************/
        
        //Get The Current Size of the Refresh Controller
        var refreshBound = self.refreshControl.bounds
        
        //Distance The Table Has Been Pulled >=0
        let pullDistance = max(0.0, -self.refreshControl.frame.origin.y)
        
        //Half The Width of The Table 
        let midX = self.tableView.frame.size.width / 2.0
        
        // Calculate the width and height of our graphics
        let refreshInsideHeight = self.refreshInside.bounds.size.height
        let refreshInsideHeightHalf = refreshInsideHeight / 2.0
        let refreshInsideWidth = self.refreshInside.bounds.size.width
        let refreshInsideWidthHalf = refreshInsideWidth / 2.0
        
        let refreshOutsideHeight = self.refreshOutside.bounds.size.height
        _ = refreshOutsideHeight / 2.0;
        let refreshOutsideWidth = self.refreshOutside.bounds.size.width
        let refreshOutsideWidthHalf = refreshOutsideWidth / 2.0
        
        // Calculate the pull ratio, between 0.0-1.0
        let pullRatio = min( max(pullDistance, 0.0), 100.0) / 100.0
        
        // Set the Y coord of the graphics, based on pull distance
        let refreshInsideY = pullDistance / 2.0 - refreshInsideHeight + 20
        let refreshOutsideY = pullDistance / 2.0 - refreshOutsideHeight + 20
        
        // Calculate the X coord of the graphics, adjust based on pull ratio
        var refreshInsideX = (midX + refreshInsideHeightHalf) - (refreshInsideWidth * pullRatio)
        var refreshOutsideX = (midX - refreshOutsideWidth - refreshOutsideWidthHalf) + (refreshOutsideWidth * pullRatio)
        
        // When the compass and spinner overlap, keep them together
        if (fabsf(Float(refreshInsideX - refreshOutsideX)) < 1.0) {
            self.isRefreshIconOverlap = true
        }
        
        // If the graphics have overlapped or we are refreshing, keep them together
        if self.isRefreshIconOverlap == true || self.refreshControl.refreshing {
            refreshInsideX = midX - refreshInsideWidthHalf
            refreshOutsideX = midX - refreshOutsideWidthHalf
        }
        
        // Set the graphic's frames
        var refreshInsideFrame = self.refreshInside.frame
        refreshInsideFrame.origin.x = refreshInsideX
        refreshInsideFrame.origin.y = refreshInsideY
        
        var refreshOutsideFrame = self.refreshOutside.frame
        refreshOutsideFrame.origin.x = refreshOutsideX
        refreshOutsideFrame.origin.y = refreshOutsideY
        
        self.refreshInside.frame = refreshInsideFrame
        self.refreshOutside.frame = refreshOutsideFrame
        
        // Set the encompassing view's frames
        refreshBound.size.height = pullDistance
        self.refreshColorView.frame = refreshBound
        self.refreshLoadingView.frame = refreshBound
        
        /*****************************************************************
        * GOOGLE ANALYTIC EVENT
        *****************************************************************/
        if (self.refreshControl!.refreshing && !self.isRefreshAnimating){
            self.animateRefreshView()
        }
    }
    
    //Scroll to Top
    @IBOutlet weak var scrollUpButton: ScrollUpButton!
    var initialTableOffset: CGFloat!
    @IBAction func scrollUpButton(sender: AnyObject) {
        hidingNavBarManager?.shouldScrollToTop()
        self.tableView.setContentOffset(CGPointMake(0, -64), animated:true)
    }
    
    /*****************************************************************
    * REFRESH CONTROL SETUP
    *****************************************************************/
    var refreshControl: UIRefreshControl!
    var refreshLoadingView: UIView!
    var refreshColorView: UIView!
    
    //Graphic View
    var refreshOutside: UIView!
    var refreshInside: UIView!
    var refreshBeach: UIImageView!
    var refreshCloudOne: UIImageView!
    var refreshCloudTwo: UIImageView!
    var refreshCloudThree: UIImageView!
    var refreshCloudFour: UIImageView!
    
    //Flags
    var isRefreshIconOverlap: Bool!
    var isRefreshAnimating: Bool!

    func setupRefreshControll(){
        
        //Programmatically Inserting a UIRefreshControl
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl.bounds.size.height = 300.0

        //Setup the Loading View. Which Will hold the Moving Graphics
        self.refreshLoadingView = UIView(frame: self.refreshControl.bounds)
        self.refreshLoadingView.backgroundColor = UIColor.clearColor()
        
        //Setup The Color View, Which Will Hold the Backgroun Color
        self.refreshColorView = UIView(frame: self.refreshControl.bounds)
        self.refreshColorView.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.refreshColorView.alpha = 1
        
        //Add Clouds One to Background
        let imageCloudOne = UIImage(named: "cloudOne")
        refreshCloudOne = UIImageView(image: imageCloudOne)
        refreshCloudOne.frame = CGRect(x: self.tableView.frame.width / 6, y: 8, width: 70, height: 28)
        refreshCloudOne.contentMode = UIViewContentMode.ScaleAspectFill
    
        //Add Clouds Two to Background
        let imageCloudTwo = UIImage(named: "cloudTwo")
        refreshCloudTwo = UIImageView(image: imageCloudTwo)
        refreshCloudTwo.frame = CGRect(x: self.tableView.frame.width / 1.5, y: 18, width: 60, height: 24)
        refreshCloudTwo.contentMode = UIViewContentMode.ScaleAspectFill
        
        //Add Clouds Three to Background
        let imageCloudThree = UIImage(named: "cloudThree")
        refreshCloudThree = UIImageView(image: imageCloudThree)
        refreshCloudThree.frame = CGRect(x: self.tableView.frame.width / 2, y: 28, width: 30, height: 12)
        refreshCloudThree.contentMode = UIViewContentMode.ScaleAspectFill
        
        //Add Clouds Four to Background
        let imageCloudFour = UIImage(named: "cloudFour")
        refreshCloudFour = UIImageView(image: imageCloudFour)
        refreshCloudFour.frame = CGRect(x: self.tableView.frame.width / 3, y: 50, width: 55, height: 22)
        refreshCloudFour.contentMode = UIViewContentMode.ScaleAspectFill
        
        //Initalize Spin Views
        self.refreshOutside = refreshActivityOutside()
        self.refreshInside = refreshActivityInside()
        
        //Set Graphic View Background
        self.refreshOutside.backgroundColor = UIColor.clearColor()
        self.refreshInside.backgroundColor = UIColor.clearColor()
        
        //Set Initial Size of graphics
        self.refreshOutside.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.refreshInside.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        //Add Refresh Background Images
        //self.refreshLoadingView.addSubview(refreshBeach) Add Beach to Background
        self.refreshLoadingView.addSubview(refreshCloudOne)
        self.refreshLoadingView.addSubview(refreshCloudTwo)
        self.refreshLoadingView.addSubview(refreshCloudThree)
        self.refreshLoadingView.addSubview(refreshCloudFour)
        
        //Add Refresh Spinner View Inside & Outside
        self.refreshLoadingView.addSubview(refreshOutside)
        self.refreshLoadingView.addSubview(refreshInside)
        
        //Clip So The Graphics Don't Stick Out
        self.refreshLoadingView.clipsToBounds = true
        
        //Hide Original Refresh Spinner
        self.refreshControl.tintColor = UIColor.clearColor()
        
        //Add Loading & Color Views To Our Refresh Controller
        self.refreshControl.addSubview(self.refreshColorView)
        self.refreshControl.addSubview(self.refreshLoadingView)
        
        //Initalize Flags
        self.isRefreshIconOverlap = false
        self.isRefreshAnimating = false
        
        //Invoke Our Refresh Function
        self.refreshControl?.addTarget(self, action: "performLoadData", forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func animateRefreshView() {
    
        //Flag That We Are Animating
        self.isRefreshAnimating = true
        
        //Start Updating Location
        self.locManager.startUpdatingLocation()
        
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            //Animate Refresh Cloud and Background Color
            UIView.animateWithDuration(30.0, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                
                //Animation Cloud
                //Reset Cloud positions
                self.refreshCloudOne.frame = CGRect(x: self.tableView.frame.width / 2, y: 8, width: 70, height: 28)
                self.refreshCloudTwo.frame = CGRect(x: self.tableView.frame.width / 3, y: 18, width: 60, height: 24)
                self.refreshCloudThree.frame = CGRect(x: self.tableView.frame.width / 6, y: 28, width: 30, height: 12)
                self.refreshCloudFour.frame = CGRect(x: self.tableView.frame.width / 1.5, y: 50, width: 55, height: 22)
                
                }, completion: nil)
            
            //Animate Refresh Circles
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                //Animation Spin In refresh
                self.refreshInside.transform = CGAffineTransformRotate(self.refreshInside.transform, CGFloat(-M_PI_2))
                self.refreshOutside.transform = CGAffineTransformRotate(self.refreshOutside.transform, CGFloat(M_PI_2))
                }, completion: {
                    (finished) -> Void in
                    if finished {
                        // If still refreshing, keep spinning, else reset
                        if (self.refreshControl!.refreshing) {
                            self.animateRefreshView()
                        }else {
                            self.resetRefreshAnimation()
                        }
                    }
            })
        }
        
    }
    
    //Reset Animation Refresh
    func resetRefreshAnimation(){
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            // Reset our flags and }background color
            self.isRefreshAnimating = false;
            self.isRefreshIconOverlap = false;
            self.refreshColorView.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
            
            //Reset Cloud positions
            self.refreshCloudOne.frame = CGRect(x: self.tableView.frame.width / 6, y: 8, width: 70, height: 28)
            self.refreshCloudTwo.frame = CGRect(x: self.tableView.frame.width / 1.5, y: 18, width: 60, height: 24)
            self.refreshCloudThree.frame = CGRect(x: self.tableView.frame.width / 2, y: 28, width: 30, height: 12)
            self.refreshCloudFour.frame = CGRect(x: self.tableView.frame.width / 3, y: 50, width: 55, height: 22)
        }
    }
    
    
    
    /*****************************************************************
    * TABLEVIEW
    *****************************************************************/
    
    //Initializeing Table View
    func setupTable(){
        //TableView Settings
        //self.tableView.rowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
        self.tableView.addSubview(refreshControl)
        
        //Inset Table View due to Extension View
        //self.tableView.contentInset = UIEdgeInsetsMake((self.navigationController?.navigationBar.frame.size.height)! + self.extensionView.frame.height, 0, 0, 0)
        
        //REGISTER CUSTOM CELLS
        let nibNormal = UINib(nibName: "NormalPostTableViewCell", bundle: nil)
        self.tableView.registerNib(nibNormal, forCellReuseIdentifier: "NormalPostCell")
        let nibPosts = UINib(nibName: "PostsTableViewCell", bundle: nil)
        self.tableView.registerNib(nibPosts, forCellReuseIdentifier: "PostsCell")
    }
    
    
    // MARK: Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return DataManager.PostData.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //Space Between Cells 
        let separatorThickness = CGFloat(4)
        let separatorSpace = UIView(frame: CGRectMake(0, cell.frame.size.height - separatorThickness, cell.frame.size.width, separatorThickness))
        separatorSpace.backgroundColor = UIColor(red: 226/255, green: 232/255, blue: 234/255, alpha: 1.0)
        cell.addSubview(separatorSpace)
        
        let lastSectionIndex: Int = tableView.numberOfSections - 1
        let lastRowIndex: Int = tableView.numberOfRowsInSection(lastSectionIndex) - 1
        if (indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex){
            self.performLoadData();
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedItem = DataManager.PostData[(indexPath.row)]
        POSTIDTOSEND = selectedItem.valueForKey("id") as! Int
        performSegueWithIdentifier("toComments", sender: self)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Init the Return of Cell Type
        var returnCell: UITableViewCell!

        /*****************************************************************
        * IMAGE CELL
        *****************************************************************/
        if(DataManager.PostData[indexPath.row].valueForKey("type") as! NSNumber == 0){
            
            let cell: NormalPostTableViewCell = tableView.dequeueReusableCellWithIdentifier("NormalPostCell", forIndexPath: indexPath) as! NormalPostTableViewCell
            
            cell.delegate = self
            cell.postPhoto.hidden = true
            
            cell.alpha = 0
            UIView.animateWithDuration(0.4, animations: {
                cell.alpha = 1
            })
            
            /*****************************************************************
            * IMAGE FOR CELL
            *****************************************************************/
            
            if (DataManager.PostData[indexPath.row].valueForKey("photoURLExtension") != nil){
                
                /*let imageCache: SDImageCache = SDImageCache.sharedImageCache()
                imageCache.cleanDisk()
                imageCache.clearMemory()*/
                
                dispatch_async(dispatch_get_main_queue()){
                    cell.postPhoto.hidden = false
                    //URL Ready and Extention
                    let URLExtention = DataManager.PostData[indexPath.row].valueForKey("photoURLExtension") as! String
                    let imageURL = NSURL(string: "https://pixabay.com/\(URLExtention)")
                    
                    //Placeholder Image
                    let sdPlaceholder: UIImage = UIImage(named: "sdPlaceholder")!
                    
                    //Load Image
                
                    cell.postPhoto.sd_setImageWithURL(imageURL)
                    cell.postPhoto.sd_setImageWithURL(imageURL, placeholderImage: sdPlaceholder)
                    
                }
            }
            
            /*****************************************************************
            * SELF INDICATOR (IMAGE POST)
            *****************************************************************/
            
            if DataManager.PostData[indexPath.row].valueForKey("user") as! String == USERID{
                cell.SelfPostIndicator.hidden = false
            } else {
                cell.SelfPostIndicator.hidden = true
            }
            
            
            /*****************************************************************
            * TEXT (IMAGE POST)
            *****************************************************************/
            
            cell.postStatus.text = DataManager.PostData[indexPath.row].valueForKey("status") as? String
            cell.postStatus.font = UIFont.systemFontOfSize(14)
            cell.postStatus.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
            
            /*****************************************************************
            * CELL RANK (IMAGE POST)
            *****************************************************************/
            
            if let totalVotes = DataManager.PostData[indexPath.row].valueForKey("numberOfVotes") as? String {
                let Formatter: NSNumberFormatter = NSNumberFormatter()
                Formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
                let totalVotesInNumber = Int(Formatter.numberFromString(totalVotes)!)
                switch (totalVotesInNumber) {
                case 0...5:
                    cell.postRankView.alpha = 0
                    break;
                case 5...15:
                    cell.postRankView.alpha = 0.10
                    
                    //Update Details Color
                    cell.postComment.tintColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.numberOfComments.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postLocationButton.tintColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postLocation.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postTime.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    break;
                case 15...25:
                    cell.postRankView.alpha = 0.25
                    
                    //Update Details Color
                    cell.postComment.tintColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.numberOfComments.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postLocationButton.tintColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postLocation.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postTime.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    break;
                case 25...35:
                    cell.postRankView.alpha = 0.35
                    
                    //Update Details Color
                    cell.postComment.tintColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.numberOfComments.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postLocationButton.tintColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postLocation.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postTime.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    break;
                case 35...45:
                    cell.postRankView.alpha = 0.45
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor.whiteColor()
                    cell.numberOfVotes.textColor = UIColor.whiteColor()
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    
                    break;
                case 45...55:
                    cell.postRankView.alpha = 0.55
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    
                    break;
                case 55...65:
                    cell.postRankView.alpha = 0.65
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    break;
                case 65...75:
                    cell.postRankView.alpha = 0.75
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    break;
                case 75...85:
                    cell.postRankView.alpha = 0.85
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    break;
                case 85...95:
                    cell.postRankView.alpha = 0.95
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    break;
                case 95...100:
                    cell.postRankView.alpha = 1.0
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    break;
                case let overTotalVote where overTotalVote > 100:
                    cell.postRankView.alpha = 1.0
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    break;
                default:
                    cell.postRankView.alpha = 0
                    break;
                }
            }else if DataManager.PostData[indexPath.row].valueForKey("numberOfVotes") is NSNull{
                cell.postRankView.alpha = 0
            }
            
            /*****************************************************************
            * VOTE (IMAGE POST)
            *****************************************************************/
            
            //Total Vote Values
            if let voteValue = DataManager.PostData[indexPath.row].valueForKey("numberOfVotes") as? String {
                cell.numberOfVotes.text = voteValue
            } else if (DataManager.PostData[indexPath.row].valueForKey("numberOfVotes") is NSNull){
                cell.numberOfVotes.text = "0"
            }
            
            
            //If cell userVote is NSNull, then nothing get highlighted
            if DataManager.PostData[indexPath.row].valueForKey("userVote") is NSNull {
                //Up Vote
                cell.upVoteButton.selected = false
                cell.upVoteButton.tintColor = UIColor.lightGrayColor()
                //Down Vote
                cell.downVoteButton.selected = false
                cell.downVoteButton.tintColor = UIColor.lightGrayColor()
                
            } else if let userVoteValue = DataManager.PostData[indexPath.row].valueForKey("userVote") as? NSNumber  {
                
                switch userVoteValue {
                case 1:
                    //Select Up Vote
                    cell.upVoteButton.selected = true
                    cell.upVoteButton.setImage(UIImage(named: "Up_Selected"), forState: UIControlState.Selected)
                    cell.downVoteButton.selected = false
                    break;
                    
                case -1:
                    //Select Down Vote
                    cell.downVoteButton.selected = true
                    cell.downVoteButton.setImage(UIImage(named: "Down_Selected"), forState: UIControlState.Selected)
                    cell.upVoteButton.selected = false
                    break;
                    
                default:
                    //Up Vote
                    cell.upVoteButton.selected = false
                    cell.upVoteButton.tintColor = UIColor.lightGrayColor()
                    //Down Vote
                    cell.downVoteButton.selected = false
                    cell.downVoteButton.tintColor = UIColor.lightGrayColor()
                    break;
                }
            }
            
            /*****************************************************************
            * COMMENTS (IMAGE POST)
            *****************************************************************/
            
            cell.numberOfComments.text = String(DataManager.PostData[indexPath.row].valueForKey("numberOfComments")!)
    
            /*****************************************************************
            * LOCATION (IMAGE POST)
            *****************************************************************/
            
            cell.postLocation.text = DataManager.PostData[indexPath.row].valueForKey("location") as? String
            
            /*****************************************************************
            * TIME (IMAGE POST)
            *****************************************************************/
            
            //IN UTC
            func getTimeData(value: NSTimeInterval) -> (count: Int, suffix: String) {
                let count = Int(floor(value))
                let suffix = count != 1 ? "s" : ""
                return (count: count, suffix: suffix)
            }
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let timeStamp = dateFormatter.dateFromString(DataManager.PostData[indexPath.row].valueForKey("time") as! String)
            let timeToShow = NSDate().timeIntervalSinceDate(timeStamp!)
            
            switch timeToShow {
            case 0...15:
                cell.postTime.text = "Now"
            case 0..<60:
                let timeDate = getTimeData(timeToShow)
                cell.postTime.text = "\(timeDate.count) s"
                
            case 0..<3600:
                let timeDate = getTimeData(timeToShow/60)
                cell.postTime.text = "\(timeDate.count) m\(timeDate.suffix)"
                
            case 0..<86400:
                let timeDate = getTimeData(timeToShow/3600)
                cell.postTime.text = "\(timeDate.count) hr\(timeDate.suffix)"
                
            case 0..<604800:
                let timeDate = getTimeData(timeToShow/86400)
                cell.postTime.text = "\(timeDate.count) d\(timeDate.suffix)"
                
            case 0..<2419200:
                let timeDate = getTimeData(timeToShow/604800)
                cell.postTime.text = "\(timeDate.count) wk\(timeDate.suffix)"
                
            case 0..<31536000:
                let timeDate = getTimeData(timeToShow/2419200)
                cell.postTime.text = "\(timeDate.count) mo\(timeDate.suffix)"
                
            default:
                let timeDate = getTimeData(timeToShow/31536000)
                cell.postTime.text = "\(timeDate.count) yr\(timeDate.suffix)"
            }
            
            //Return Photo Cell
            returnCell = cell

        }else if(DataManager.PostData[indexPath.row].valueForKey("type") as! NSNumber == 1){
            
            /*****************************************************************
            * TEXT CELL
            *****************************************************************/
            
            let cell: PostsTableViewCell = tableView.dequeueReusableCellWithIdentifier("PostsCell", forIndexPath: indexPath) as! PostsTableViewCell
            
            cell.delegate = self
            
            cell.alpha = 0
            UIView.animateWithDuration(0.4, animations: {
                cell.alpha = 1
            })
            
            /*****************************************************************
            * SELF INDICATOR
            *****************************************************************/
            
            if DataManager.PostData[indexPath.row].valueForKey("user") as! String == USERID{
                cell.SelfPostIndicator.hidden = false
            } else {
                cell.SelfPostIndicator.hidden = true
            }
            
            /*****************************************************************
            * TEXT (TEXT POST)
            *****************************************************************/
            
            cell.postStatus.text = DataManager.PostData[indexPath.row].valueForKey("status") as? String
            cell.postStatus.font = UIFont.systemFontOfSize(14)
            cell.postStatus.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
            
            /*****************************************************************
            * RANK (TEXT POST)
            *****************************************************************/
            
            if let totalVotes = DataManager.PostData[indexPath.row].valueForKey("numberOfVotes") as? String {
                let Formatter: NSNumberFormatter = NSNumberFormatter()
                Formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
                let totalVotesInNumber = Int(Formatter.numberFromString(totalVotes)!)
                switch (totalVotesInNumber) {
                case 0...5:
                    cell.postRankView.alpha = 0
                    break;
                case 5...15:
                    cell.postRankView.alpha = 0.10
                    
                    //Update Details Color
                    cell.postComment.tintColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.numberOfComments.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postLocationButton.tintColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postLocation.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postTime.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    break;
                case 15...25:
                    cell.postRankView.alpha = 0.25
                    
                    //Update Details Color
                    cell.postComment.tintColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.numberOfComments.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postLocationButton.tintColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postLocation.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postTime.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    break;
                case 25...35:
                    cell.postRankView.alpha = 0.35
                    
                    //Update Details Color
                    cell.postComment.tintColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.numberOfComments.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postLocationButton.tintColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postLocation.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    cell.postTime.textColor = UIColor(red: 95/255, green: 112/255, blue: 122/255, alpha: 1.0)
                    break;
                case 35...45:
                    cell.postRankView.alpha = 0.45
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor.whiteColor()
                    cell.numberOfVotes.textColor = UIColor.whiteColor()
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)

                    break;
                case 45...55:
                    cell.postRankView.alpha = 0.55
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)

                    break;
                case 55...65:
                    cell.postRankView.alpha = 0.65
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    break;
                case 65...75:
                    cell.postRankView.alpha = 0.75
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    break;
                case 75...85:
                    cell.postRankView.alpha = 0.85
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    break;
                case 85...95:
                    cell.postRankView.alpha = 0.95
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    break;
                case 95...100:
                    cell.postRankView.alpha = 1.0
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    break;
                case let overTotalVote where overTotalVote > 100:
                    cell.postRankView.alpha = 1.0
                    
                    //Update Details Color
                    cell.SelfPostIndicator.DefaultColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.postStatus.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    cell.numberOfVotes.textColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1.0)
                    break;
                  default:
                    cell.postRankView.alpha = 0
                    break;
                }
            }else if DataManager.PostData[indexPath.row].valueForKey("numberOfVotes") is NSNull{
                cell.postRankView.alpha = 0
            }
            
            /*****************************************************************
            * VOTES (TEXT POST)
            *****************************************************************/

            //Total Vote Values
            if let voteValue = DataManager.PostData[indexPath.row].valueForKey("numberOfVotes") as? String {
                cell.numberOfVotes.text = voteValue
            } else if (DataManager.PostData[indexPath.row].valueForKey("numberOfVotes") is NSNull){
                cell.numberOfVotes.text = "0"
            }
            
            
            //If cell userVote is NSNull, then nothing get highlighted
            if DataManager.PostData[indexPath.row].valueForKey("userVote") is NSNull {
                
                //Up Vote
                cell.upVoteButton.selected = false
                cell.upVoteButton.tintColor = UIColor.lightGrayColor()
                
                //Down Vote
                cell.downVoteButton.selected = false
                cell.downVoteButton.tintColor = UIColor.lightGrayColor()
                
            } else if let userVoteValue = DataManager.PostData[indexPath.row].valueForKey("userVote") as? NSNumber  {
                
                switch userVoteValue {
                case 1:
                    //Select Up Vote
                    cell.upVoteButton.selected = true
                    cell.upVoteButton.setImage(UIImage(named: "Up_Selected"), forState: UIControlState.Selected)
                    
                    cell.downVoteButton.selected = false
                    cell.downVoteButton.transform = CGAffineTransformMakeScale(0.85, 0.85)
                    
                    break;
                    
                case -1:
                    //Select Down Vote
                    cell.downVoteButton.selected = true
                    cell.downVoteButton.setImage(UIImage(named: "Down_Selected"), forState: UIControlState.Selected)
                    
                    cell.upVoteButton.selected = false
                    cell.upVoteButton.transform = CGAffineTransformMakeScale(0.85, 0.85)
                    break;
                    
                default:
                    //Up Vote
                    cell.upVoteButton.selected = false
                    cell.upVoteButton.tintColor = UIColor.lightGrayColor()
                    //Down Vote
                    cell.downVoteButton.selected = false
                    cell.downVoteButton.tintColor = UIColor.lightGrayColor()
                    break;
                }
            }
            
            /*****************************************************************
            * COMMENTS (TEXT POST)
            *****************************************************************/
           
            cell.numberOfComments.text = String(DataManager.PostData[indexPath.row].valueForKey("numberOfComments")!)

            /*****************************************************************
            * LOCATION (TEXT POST)
            *****************************************************************/
            
            cell.postLocation.text = DataManager.PostData[indexPath.row].valueForKey("location") as? String
            
            /*****************************************************************
            * TIME (TEXT POST)
            *****************************************************************/
            
            //IN UTC
            func getTimeData(value: NSTimeInterval) -> (count: Int, suffix: String) {
                let count = Int(floor(value))
                let suffix = count != 1 ? "s" : ""
                return (count: count, suffix: suffix)
            }
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let timeStamp = dateFormatter.dateFromString(DataManager.PostData[indexPath.row].valueForKey("time") as! String)
            let timeToShow = NSDate().timeIntervalSinceDate(timeStamp!)
            
            switch timeToShow {
            case 0...15:
                cell.postTime.text = "Now"
            case 0..<60:
                let timeDate = getTimeData(timeToShow)
                cell.postTime.text = "\(timeDate.count) s"
                
            case 0..<3600:
                let timeDate = getTimeData(timeToShow/60)
                cell.postTime.text = "\(timeDate.count) m\(timeDate.suffix)"
                
            case 0..<86400:
                let timeDate = getTimeData(timeToShow/3600)
                cell.postTime.text = "\(timeDate.count) hr\(timeDate.suffix)"
                
            case 0..<604800:
                let timeDate = getTimeData(timeToShow/86400)
                cell.postTime.text = "\(timeDate.count) d\(timeDate.suffix)"
                
            case 0..<2419200:
                let timeDate = getTimeData(timeToShow/604800)
                cell.postTime.text = "\(timeDate.count) wk\(timeDate.suffix)"
                
            case 0..<31536000:
                let timeDate = getTimeData(timeToShow/2419200)
                cell.postTime.text = "\(timeDate.count) mo\(timeDate.suffix)"
                
            default:
                let timeDate = getTimeData(timeToShow/31536000)
                cell.postTime.text = "\(timeDate.count) yr\(timeDate.suffix)"
            }
            
            //Return Text Cell
            returnCell = cell
        }
        return returnCell
    }
    
    /*****************************************************************
    * CELL OPTION VIEW
    *****************************************************************/
    
    //Selected Cell
    var optionsIndexPath: NSIndexPath!
    var optionsSelected: NSDictionary!
    var optionsSelectedID: Int!
    var optionsSelectedPhoto: String!
    
    //UIViews
    @IBOutlet var OptionsDialog: UIView!
    @IBOutlet var deleteOptions: UIButton!
    @IBOutlet var cancelOptions: UIButton!
    @IBOutlet var CellLongPress: UILongPressGestureRecognizer!
    
    //UIView Visibility Indicator
    var isDeleteOptionVisible: Bool! = false
    var isReportOptionVisible: Bool! = false
    
    //Bring Up Options
    @IBAction func cellLongPress(PointGesture: UILongPressGestureRecognizer){
        
        let Point: CGPoint = PointGesture.locationInView(self.tableView)
        optionsIndexPath = self.tableView.indexPathForRowAtPoint(Point)
        optionsSelected = DataManager.PostData[(optionsIndexPath?.row)!] as! NSDictionary
        
        //Get Item Information for Option
        if PointGesture.state == UIGestureRecognizerState.Began {
            
            //Update UI
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                //Show Menu Option
                self.coverView.hidden = false
                self.OptionsDialog.hidden = false
                self.CellLongPress.enabled = false
                self.menuButton.enabled = false
                self.tableView.userInteractionEnabled = false
                
                //Apply Shadow to Option Dialog
                self.OptionsDialog.layer.masksToBounds = true
                self.OptionsDialog.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25).CGColor
                self.OptionsDialog.layer.shadowOpacity = 1.0
                self.OptionsDialog.clipsToBounds = false
                self.OptionsDialog.layer.shadowOffset = CGSize(width: 1.0, height: -40.0)
                self.OptionsDialog.layer.shadowRadius = 50
                
                //Hide Other Buttons
                UIView.animateWithDuration(0.4, animations: {
                    self.AddPostButton.frame.offsetInPlace(dx: 0, dy: 100)
                    self.scrollUpButton.frame.offsetInPlace(dx: 0, dy: 100)
                })
            }
            
            if optionsIndexPath != nil {
                if optionsSelected.valueForKey("id") != nil {
                    optionsSelectedID = optionsSelected.valueForKey("id") as! Int
                    if optionsSelected.valueForKey("type") as! Int != 1 {
                        optionsSelectedPhoto = optionsSelected.valueForKey("photoURLExtension") as! String
                    }
                }
            }
            
            //if user id of post don't match show report
            if optionsSelected.valueForKey("user") as? String != USERID {
                
                //Report Option is Visible
                self.isReportOptionVisible = true
                
                //Report TextField become Active
                self.reportTextView.becomeFirstResponder()
            
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.reportView.hidden = false
                    UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                        self.reportView.alpha = 1
                        self.reportView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
                        }, completion: nil)
                })
            }
            
            //if user id match show delete option
            if optionsSelected.valueForKey("user") as! String == USERID {
                
                //Delete Options is Visible
                self.isDeleteOptionVisible = true
                
                //Show Delete Button
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                        self.deleteOptions.frame.offsetInPlace(dx: 0, dy: -100)
                        }, completion: nil)
                    })
                
                //Show Cancel
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    UIView.animateWithDuration(0.2, delay: 0.18, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                        self.cancelOptions.frame.offsetInPlace(dx: 0, dy: -50)
                        }, completion: nil)
                })
            }

        }
        
    }
    
    
    
    
    /*****************************************************************
    * REPORT POST
    *****************************************************************/
    
    @IBOutlet var reportView: UIView!
    @IBOutlet var reportTextView: UITextView!
    @IBOutlet var reportPostButton: FlagButton!
    @IBOutlet var reportTextCount: UILabel!
    
    func reportViewSetup(){
        
        //Disable Flagging on Intial
        self.reportPostButton.enabled = false

        //Hide Report View Initially
        self.reportView.hidden = true
        self.reportView.alpha = 0
        self.reportView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0)
        
        //Reporting View Inital Setting
        self.reportView.layer.shadowColor = UIColor.blackColor().CGColor
        self.reportView.layer.shadowOpacity = 0.3
        self.reportView.layer.shadowRadius = 15.0
        self.reportView.layer.shadowOffset = CGSizeMake(0, 2.0)
        self.reportView.layer.masksToBounds = false
        
        //Report Text View
        self.reportTextView.layer.borderColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0).CGColor
        self.reportTextView.layer.borderWidth = 1
        self.reportTextView.layer.cornerRadius = 4
        
    }
    
    //Store Report Reason
    var reportLevel: Int?
    
    //Check Report as Spam
    @IBOutlet var isSpamReport: UIButton!
    @IBAction func isSpamReport(sender: AnyObject) {
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(0.3, animations: {
                //Select Spam as Reason
                self.isSpamReport.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
                self.isSpamReport.setTitleColor(UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0), forState: UIControlState.Normal)
                }) { (finished) -> Void in
                    //Change Reason to Spam
                    self.reportLevel = 1
                    //Change offensive to Normal
                    if self.reportLevel! == 1 {
                        self.reportPostButton.enabled = true
                        UIView.animateWithDuration(0.2, animations: {
                            self.isOffensiveReport.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
                            self.isOffensiveReport.setTitleColor(UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0), forState: UIControlState.Normal)
                        })
                    }
            }
        }
    }
    
    //Check Report as Offensive
    @IBOutlet var isOffensiveReport: UIButton!
    @IBAction func isOffensiveReport(sender: AnyObject) {
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(0.3, animations: {
                //Select Offensive as Reason
                self.isOffensiveReport.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
                self.isOffensiveReport.setTitleColor(UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0), forState: UIControlState.Normal)
                }) { (finished) -> Void in
                    //Change Reason to Offensive
                    self.reportLevel = 2
                    //Change offensive to Normal
                    if self.reportLevel! == 2 {
                        self.reportPostButton.enabled = true
                        UIView.animateWithDuration(0.2, animations: {
                            self.isSpamReport.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
                            self.isSpamReport.setTitleColor(UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0), forState: UIControlState.Normal)
                        })
                    }
            }
        }
    }
    
    
    /* REPORT LEVELS
    
    * 1 = SPAM
    * 2 = OFFENSIVE
    
    */
    
    @IBAction func reportPost(sender: AnyObject) {
        
        //Parameters to Send
        let Paramater = [
            "post": self.optionsSelected.valueForKey("id") as! Int,
            "level": reportLevel!,
            "reason": "\(reportTextView.text!) ",
            "user": USERID!
        ]
        
        //Send Request to Server
        Alamofire.request(.POST, "http://vilvas.com/test/user/flag/post.php", parameters: Paramater as? [String : AnyObject])
            .responseJSON{ response in
                switch response.result{
                    
                case .Success(let JSON):
                    
                    if JSON.valueForKey("Status") as! String == "OK" {
                        self.notifyMessage(UIColor(red: 0.425, green: 0.476, blue: 0.518, alpha: 1.000), setTextColor: UIColor.whiteColor(), setNotifyMessage: "Post flagged.")
                        
                        self.CancelPostOptions(self)
                    }
                    
                case .Failure(_):
                    
                    self.notifyMessage(UIColor(red: 0.966, green: 0.355, blue: 0.355, alpha: 1.000), setTextColor: UIColor.whiteColor(), setNotifyMessage: "Fail to flag.")
                    
                    self.CancelPostOptions(self)
                }
        }
        
        
    }

    @IBAction func cancelReport(sender: AnyObject) {
       self.CancelPostOptions(self)
    }
    
    /*****************************************************************
    * DELETE POST
    *****************************************************************/

    @IBAction func DeletePost(sender: AnyObject) {
        
        //Paramaters to Send
        var paramtersToDelete: NSDictionary?
        
        //Paramaters to Send for Text Post
        if optionsSelected.valueForKey("type") as! Int == 1{
            paramtersToDelete = [
                "user": USERID,
                "post": optionsSelectedID,
                "type": optionsSelected.valueForKey("type") as! Int
            ]
        }
        
        //Paramaters to Send for Photo Post
        if optionsSelected.valueForKey("type") as! Int == 0{
            paramtersToDelete = [
                "user": USERID,
                "post": optionsSelectedID,
                "type": optionsSelected.valueForKey("type") as! Int,
                "photo": optionsSelectedPhoto
            ]
        }
        
        Alamofire.request(.POST, "http://vilvas.com/test/user/delete/post.php", parameters: paramtersToDelete as? [String : AnyObject])
            .responseJSON{response in
                //if Successfully Deleted
                switch response.result {
                case .Success(let JSON):
                    
                    //If Deleting Success, Match Return Value ID to selected ID
                    if Int(JSON.valueForKey("id") as! String) == self.optionsSelectedID {
                        
                        //Delete Object From Post Data
                        if DataManager.DeleteObject(Int(JSON.valueForKey("id") as! String)!, inArray: DataManager.PostData) {
                            
                            //Once Item Found Remove it and Resload Data
                            dispatch_async(dispatch_get_main_queue(), {
                                self.performLoadData()
                                self.tableView.reloadData()
                                self.CancelPostOptions(self)
                            })
                        }
                    }
                    
                case .Failure(_):
                    //hide options
                    self.CancelPostOptions(self)
                    //Notify user Fail to Delete
                    let deleteFailedAlert: UIAlertView = UIAlertView(title: "Fail", message: "Failed to delete. Please try again later.", delegate: self, cancelButtonTitle: "Sure!")
                    deleteFailedAlert.show()
                }
            }
    }
    
    /*****************************************************************
    * CANCEL CELL OPTION VIEW
    *****************************************************************/
    @IBAction func CancelPostOptions(sender: AnyObject) {
        
        //Hide Report Option if is Visible
        if self.isReportOptionVisible == true {
            
            //Report Option is Hidden
            self.isReportOptionVisible = false
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.reportView.alpha = 0
                    self.reportView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0)
                    }, completion: {
                        (finished) -> Void in
                        
                        //Report text Field Keyboard
                        self.reportTextView.resignFirstResponder()
                        self.reportTextView.text = nil
                        self.reportTextCount.text = "120"
                        
                        //Reset Spam Button
                        self.isSpamReport.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
                        self.isSpamReport.setTitleColor(UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0), forState: UIControlState.Normal)
                        
                        //Reset Offensive Button
                        self.isOffensiveReport.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
                        self.isOffensiveReport.setTitleColor(UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0), forState: UIControlState.Normal)
                        
                        //Empty Level and Disabel Button Again
                        self.reportLevel = nil
                        self.reportPostButton.enabled = false
                        
                        //HGide Report View
                        self.reportView.hidden = true
                })
            })
        }
        
        //Hide Delete Button and Cancel if is Visiable
        if self.isDeleteOptionVisible == true {
            self.isDeleteOptionVisible = false
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                    self.deleteOptions.frame.offsetInPlace(dx: 0, dy: 100)
                    }, completion: nil)
            })
            
            //Hide Cancel Button
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIView.animateWithDuration(0.2, delay: 0.18, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                    self.cancelOptions.frame.offsetInPlace(dx: 0, dy: 50)
                    }, completion: nil)
            })
        }
        
        
        
        //Initilize View Again
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            //Hide Menu Option
            self.coverView.hidden = true
            self.OptionsDialog.hidden = true
            self.CellLongPress.enabled = true
            self.tableView.scrollEnabled = true
            self.menuButton.enabled = true
            self.tableView.userInteractionEnabled = true
            
            //Show Other Buttons
            UIView.animateWithDuration(0.4, animations: {
                self.AddPostButton.frame.offsetInPlace(dx: 0, dy: -100)
                self.scrollUpButton.frame.offsetInPlace(dx: 0, dy: -100)
            })
        })
        
    }
    
    /*****************************************************************
    * COMMENT BUTTON
    *****************************************************************/
    
    var POSTIDTOSEND: Int!
    func Comments(cell: NormalPostTableViewCell) {
        
        let indexPath = self.tableView.indexPathForRowAtPoint(cell.center)
        let selectedItem = DataManager.PostData[(indexPath?.row)!]
        
        POSTIDTOSEND = selectedItem.valueForKey("id") as! Int

        performSegueWithIdentifier("toComments", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toComments" {
            let ExchangeViewData = segue.destinationViewController as! CommentsViewController
            ExchangeViewData.POSTIDRECIEVED = POSTIDTOSEND
        }
    }

    
    /*****************************************************************
    * VOTE UP
    *****************************************************************/
    func voteUp(cell: NormalPostTableViewCell) {
        if cell.upVoteButton.selected {
            
            //Get Current Index
            let indexPath = self.tableView.indexPathForRowAtPoint(cell.center)
            
            //Paramters to Send
            let Paramaters = [
                "user": USERID,
                "post": DataManager.PostData[(indexPath?.row)!].valueForKey("id") as! NSNumber
            ]
            
            Alamofire.request(.POST, "http://vilvas.com/test/user/delete/vote.php", parameters: Paramaters)
                .responseJSON{ response in
                    //if Successfully Delete Vote
                    switch response.result {
                    case .Success(let JSON):
                        
                        //Convert JSON to Array
                        let json = JSON as! NSDictionary
                
                        switch (json.valueForKey("id")) {
                        case is NSNull:
                            dispatch_async(dispatch_get_main_queue()){
                                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                                    cell.numberOfVotes.alpha = 0.0
                                    }, completion: {
                                        (finished: Bool) -> Void in
                                        
                                        //Once the label is completely invisible, set the text and fade it back in
                                        cell.numberOfVotes.text = "0"
                                        cell.numberOfVotes.center.y = 50
                                        
                                        // Fade in
                                        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                                            cell.numberOfVotes.alpha = 1.0
                                            cell.numberOfVotes.center.y = cell.ActionDetail.bounds.size.height/2
                                            }, completion: nil)
                                })
                            }
                            break;
                            
                        default:
                            let totalVote: String = json.valueForKey("votes") as! String
                            dispatch_async(dispatch_get_main_queue()){
                                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                                    cell.numberOfVotes.alpha = 0.0
                                    }, completion: {
                                        (finished: Bool) -> Void in
                                        
                                        //Once the label is completely invisible, set the text and fade it back in
                                        cell.numberOfVotes.text = totalVote
                                        cell.numberOfVotes.center.y = 50
                                        
                                        // Fade in
                                        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                                            cell.numberOfVotes.alpha = 1.0
                                            cell.numberOfVotes.center.y = cell.ActionDetail.bounds.size.height/2
                                            }, completion: nil)
                                })
                            }
                            break;
                        }
                        
                        //Update UI
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            cell.upVoteButton.selected = false
                            
                            //Scale Down vote to Normal
                            UIView.animateWithDuration(0.2, animations: {
                                cell.downVoteButton.transform = CGAffineTransformMakeScale(1, 1)
                            })
                        })

                    case .Failure(_):
                        //Notify user Fail to Unvote
                        let voteFailedAlert: UIAlertView = UIAlertView(title: "Fail", message: "Failed to Unvote. Please try again later.", delegate: self, cancelButtonTitle: "Sure!")
                        voteFailedAlert.show()
                    }
                }
        }else {
            
            //Get Current Index
            let indexPath = self.tableView.indexPathForRowAtPoint(cell.center)
            
            //Paramters to Send
            let Paramaters = [
                "user": USERID,
                "post": DataManager.PostData[(indexPath?.row)!].valueForKey("id") as! NSNumber,
                "vote": "1"
            ]
            
            Alamofire.request(.POST, "http://vilvas.com/test/vote.php", parameters: Paramaters)
                .responseJSON{ response in
                    //if Successfully Vote
                    switch response.result {
                    case .Success(let JSON):
                        
                        //Convert JSON to Array
                        let json = JSON as! NSDictionary
                       
                        if(json.valueForKey("id") as! NSNumber == DataManager.PostData[(indexPath?.row)!].valueForKey("id") as! NSNumber){
                            dispatch_async(dispatch_get_main_queue()){
                                let totalVote = json.valueForKey("votes") as! String
                                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                                    cell.numberOfVotes.alpha = 0.0
                                    }, completion: {
                                        (finished: Bool) -> Void in
                                        
                                        //Selected
                                        cell.upVoteButton.setImage(UIImage(named: "Up_Selected"), forState: UIControlState.Selected)
                                        
                                        //Once the label is completely invisible, set the text and fade it back in
                                        cell.numberOfVotes.text = totalVote
                                        cell.numberOfVotes.center.y = 50
                                        
                                        // Fade in
                                        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                                            cell.numberOfVotes.alpha = 1.0
                                            cell.numberOfVotes.center.y = cell.ActionDetail.bounds.size.height/2
                                            }, completion: nil)
                                })
                            }
                        }
                        
                        //Update UI
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            cell.upVoteButton.selected = true
                            cell.downVoteButton.selected = false
                            
                            //Scale
                            UIView.animateWithDuration(0.2, animations: {
                                cell.upVoteButton.transform = CGAffineTransformMakeScale(1, 1)
                                cell.downVoteButton.transform = CGAffineTransformMakeScale(0.85, 0.85)
                            })
                        })
                        
                    case .Failure(_):
                        //Notify user Fail to Vote
                        let voteFailedAlert: UIAlertView = UIAlertView(title: "Fail", message: "Failed to Vote. Please try again later.", delegate: self, cancelButtonTitle: "Sure!")
                        voteFailedAlert.show()
                    }
            }
        }
    }
    
    /*****************************************************************
    * VOTE DOWN
    *****************************************************************/
    
    func voteDown(cell: NormalPostTableViewCell) {
        if cell.downVoteButton.selected {

            //Get Current Index
            let indexPath = self.tableView.indexPathForRowAtPoint(cell.center)
            
            //Paramters to Send
            let Paramaters = [
                "user": USERID,
                "post": DataManager.PostData[(indexPath?.row)!].valueForKey("id") as! NSNumber
            ]
            
            Alamofire.request(.POST, "http://vilvas.com/test/user/delete/vote.php", parameters: Paramaters)
                .responseJSON{ response in
                    //if Successfully Delete Vote
                    switch response.result {
                    case .Success(let JSON):
                        
                        //Convert JSON to Array
                        let json = JSON as! NSDictionary
                        
                        switch (json.valueForKey("id")) {
                        case is NSNull:
                            dispatch_async(dispatch_get_main_queue()){
                                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                                    cell.numberOfVotes.alpha = 0.0
                                    }, completion: {
                                        (finished: Bool) -> Void in
                                        
                                        //Once the label is completely invisible, set the text and fade it back in
                                        cell.numberOfVotes.text = "0"
                                        cell.numberOfVotes.center.y = 50
                                        
                                        // Fade in
                                        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                                            cell.numberOfVotes.alpha = 1.0
                                            cell.numberOfVotes.center.y = cell.ActionDetail.bounds.size.height/2
                                            }, completion: nil)
                                })
                            }
                            break;
                            
                        default:
                            let totalVote: String = json.valueForKey("votes") as! String
                            dispatch_async(dispatch_get_main_queue()){
                                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                                    cell.numberOfVotes.alpha = 0.0
                                    }, completion: {
                                        (finished: Bool) -> Void in
                                        
                                        //Once the label is completely invisible, set the text and fade it back in
                                        cell.numberOfVotes.text = totalVote
                                        cell.numberOfVotes.center.y = 50
                                        
                                        // Fade in
                                        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                                            cell.numberOfVotes.alpha = 1.0
                                            cell.numberOfVotes.center.y = cell.ActionDetail.bounds.size.height/2
                                            }, completion: nil)
                                })
                            }
                            break;
                        }
                        
                        //Update UI
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            cell.downVoteButton.selected = false
                            
                            //Scale Up vote to Normal
                            UIView.animateWithDuration(0.2, animations: {
                                cell.upVoteButton.transform = CGAffineTransformMakeScale(1, 1)
                            })
                        })
                        
                    case .Failure(_):
                        //Notify user Fail to Unvote
                        let voteFailedAlert: UIAlertView = UIAlertView(title: "Fail", message: "Failed to Unvote. Please try again later.", delegate: self, cancelButtonTitle: "Sure!")
                        voteFailedAlert.show()
                    }
            }

        }else {
            
            //Get Current Index
            let indexPath = self.tableView.indexPathForRowAtPoint(cell.center)
            
            //Paramters to Send
            let Paramaters = [
                "user": USERID,
                "post": DataManager.PostData[(indexPath?.row)!].valueForKey("id") as! NSNumber,
                "vote": "-1"
            ]
            
            Alamofire.request(.POST, "http://vilvas.com/test/vote.php", parameters: Paramaters)
                .responseJSON{ response in
                    //if Successfully Vote
                    switch response.result {
                    case .Success(let JSON):
                        
                        //Convert JSON to Array
                        let json = JSON as! NSDictionary
                        
                        if(json.valueForKey("id") as! NSNumber == DataManager.PostData[(indexPath?.row)!].valueForKey("id") as! NSNumber){
                            dispatch_async(dispatch_get_main_queue()){
                                let totalVote = json.valueForKey("votes") as! String
                                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                                    cell.numberOfVotes.alpha = 0.0
                                    }, completion: {
                                        (finished: Bool) -> Void in
                                        
                                        //Selected
                                        cell.downVoteButton.setImage(UIImage(named: "Down_Selected"), forState: UIControlState.Selected)
                                        
                                        //Once the label is completely invisible, set the text and fade it back in
                                        cell.numberOfVotes.text = totalVote
                                        cell.numberOfVotes.center.y = 50
                                        
                                        // Fade in
                                        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                                            cell.numberOfVotes.alpha = 1.0
                                            cell.numberOfVotes.center.y = cell.ActionDetail.bounds.size.height/2
                                            }, completion:nil)
                                })
                            }
                        }
                        
                        //Update UI
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            cell.upVoteButton.selected = false
                            cell.downVoteButton.selected = true
                            
                            //Scale
                            UIView.animateWithDuration(0.2, animations: {
                                cell.upVoteButton.transform = CGAffineTransformMakeScale(0.85, 0.85)
                                cell.downVoteButton.transform = CGAffineTransformMakeScale(1, 1)
                            })
                        })
                        
                    case .Failure(_):
                        //Notify user Fail to Vote
                        let voteFailedAlert: UIAlertView = UIAlertView(title: "Fail", message: "Failed to Vote. Please try again later.", delegate: self, cancelButtonTitle: "Sure!")
                        voteFailedAlert.show()
                    }
            }
        }
    }
    
    /*****************************************************************
    * LOCATION SETTING
    *****************************************************************/
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locManager.stopUpdatingLocation()
        
        let location: CLLocation = locations[0] as CLLocation
        let geoCoder = CLGeocoder()
    
        longitude = Float(location.coordinate.longitude)
        latitude = Float(location.coordinate.latitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: {(data, error)-> Void in
            let currentLocation = data as [CLPlacemark]!
            
            if currentLocation != nil {
                if let loc: CLPlacemark = currentLocation[0] {
                    let city = loc.locality
                    let region = loc.administrativeArea
                    let newLocationInString = self.LocationInString
                    self.LocationInString = "\(city!), \(region!)"
                    
                    //Update UI
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        //Update New Location in Navigation if Changed
                        if self.LocationInString != newLocationInString {
                            //View Title for Navigation Update with Location
                            let titleName: String = "Happening"
                            let titleViewUpdate = "\(titleName) \n \(self.LocationInString!)"
                            let titleLabel: NSMutableAttributedString = NSMutableAttributedString(string: titleViewUpdate)
                            let titleAttribute = [
                                NSForegroundColorAttributeName: UIColor.whiteColor(),
                                NSFontAttributeName: UIFont.boldSystemFontOfSize(13)
                            ]
                            
                            titleLabel.setAttributes(titleAttribute, range: NSMakeRange(0, titleName.characters.count))
                            self.titleView = UILabel(frame: CGRectMake(0, 0, (self.navigationController?.navigationBar.frame.width)!, (self.navigationController?.navigationBar.frame.height)!))
                            self.titleView.numberOfLines = 2
                            self.titleView.textAlignment = NSTextAlignment.Center
                            self.titleView.backgroundColor = UIColor.clearColor()
                            self.titleView.font = UIFont.systemFontOfSize(10)
                            self.titleView.textColor = UIColor.whiteColor()
                            UIView.transitionWithView((self.navigationController?.navigationBar)!, duration: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                                self.titleView.attributedText = titleLabel
                                }, completion: nil)
                            self.titleView.sizeToFit()
                            self.navigationItem.titleView = self.titleView
                        }
                    }
                }
            }
        })
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //Alert Location Fail
        let selfIndicatorOFFAlert: UIAlertView = UIAlertView(title: "Location Faild", message: "\(error.localizedDescription)", delegate: self, cancelButtonTitle: "OK")
        selfIndicatorOFFAlert.show()
        return
    }
    
    /*****************************************************************
    * FETCHING DATA FROM SERVER/DATABASE
    *****************************************************************/
    
    var initialItems: Int = 0 //Intial Load Item
    var currentItems: Int! //Current Items
    
    @IBOutlet var ActivityLoadOutSide: ActivityLoadOutsideView!
    @IBOutlet var ActivityLoadInside: ActivityLoadInsideView!
    var animateActivity: Bool!
    
    //Perform data
    func performLoadData(){
        
        //Start Loading View Animation
        startLoadingActivity()
        
        //Initial Loading View
        loadingActivity()
        
        //Track Previous Load Count
        let previousLoadDataCount = DataManager.PostData.count
        
        
        //Get User Discovery Distance
        let discoveryDistance: Int! = NSUserDefaults.standardUserDefaults().integerForKey("discoveryDistance")

        //Items in Timeline Already
        currentItems = DataManager.PostData.count
        
        //Paramter to Send to Server
        let paramaterToPullData: NSDictionary  = [
            "latitude": Float(locManager.location!.coordinate.latitude),
            "longitude": Float(locManager.location!.coordinate.longitude),
            "radius": discoveryDistance,
            "user": USERID,
            "currentItems": currentItems
        ]
        
        //Server Request
        Alamofire.request(.POST, "http://vilvas.com/test/pull.php", parameters: paramaterToPullData as? [String : AnyObject])
        .responseJSON{response in
            //if Successfully Pull Data
            switch response.result {
            case .Success(let JSON):
                
                //Convert JSON to Array
                let json = JSON as! NSArray
                
                
                //If previous load data don't contain the same post, update the array of loaddata.
                for object in json {
                    
                    //Check if Post ID Exist in Array
                    let CheckObject = DataManager.PostData.indexOfObjectPassingTest { (resultFind, ind, bool) -> Bool in
                        return resultFind["id"] as? Int == object.valueForKey("id") as? Int
                    }
                    
                    //If Not Found
                    if CheckObject == NSNotFound {
                        //Add the Object to Array
                        DataManager.PostData.insertObject(object, atIndex: 0)
                    }
                    
                }
                
                //Sort Array by Distance (NSUserDefault)
                if NSUserDefaults.standardUserDefaults().objectForKey("sortBy") as! String == "distance" {
                    let sortedByDistanceDes: NSSortDescriptor = NSSortDescriptor(key: "distance", ascending: false)
                    let SortedDistanceArray: NSMutableArray = NSMutableArray(array: DataManager.PostData!.sortedArrayUsingDescriptors([sortedByDistanceDes]))
                    DataManager.PostData = SortedDistanceArray
                }
                
                //Sory Array by Location (NSUserDefault)
                if NSUserDefaults.standardUserDefaults().objectForKey("sortBy") as! String == "latest" {
                    let sortedByTimeDes: NSSortDescriptor = NSSortDescriptor(key: "time", ascending: false)
                    let SortedTimeArray: NSMutableArray = NSMutableArray(array: DataManager.PostData!.sortedArrayUsingDescriptors([sortedByTimeDes]))
                    DataManager.PostData = SortedTimeArray
                }
                
                //Check if There is any data in available
                if DataManager.PostData.count >= 1 {
                    
                    //Stop Loading View Animation
                    self.stopLoadingActivity()
                }
                
                //End Pull Refresh if It began base on 3 second
                let delayInSeconds = 3.0
                let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
                dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
                    
                    //Check If No data available
                    if DataManager.PostData.count <= 0 {
                        
                        //show no data View.
                        self.showNoDataMessage()
                    }
                    
                    // When done requesting/reloading/processing invoke endRefreshing, to close the control
                    self.refreshControl!.endRefreshing()
                }
                
                
                
                //Stop Updateing Location
                self.locManager.stopUpdatingLocation()
                
                //Finally Reload Table if new data available
                if previousLoadDataCount != DataManager.PostData.count {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.locManager.stopUpdatingLocation()
                        self.tableView.reloadData()
                    })
                }
                
                //Show Fail to pull data message.
            case .Failure(_):
                
                //Notify user Fail to pull data
                let deleteFailedAlert: UIAlertView = UIAlertView(title: "Fail", message: "Failed to load posts. Please try again later or check your network connection.", delegate: self, cancelButtonTitle: "Sure!")
                deleteFailedAlert.show()
            }
        }
    }
    
    /*****************************************************************
    * LOADING VIEW
    *****************************************************************/
    
    func loadingActivity(){
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if self.animateActivity == true {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    
                    
                    //Loading Activity Outside Ring Animation
                    let backwardRotateActivityLoadingOutside = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
                    let zoomOutActivityLoadingOutside = CGAffineTransformMakeScale(1.1, 1.1)
                    
                    self.ActivityLoadOutSide.transform = CGAffineTransformConcat(backwardRotateActivityLoadingOutside, zoomOutActivityLoadingOutside)
                    
                    
                    
                    //Loading Activity Inside Ring Animation
                    let forwardRotateActivityLoadingInside = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                    let zoomInActivityLoadingInside = CGAffineTransformMakeScale(0.8, 0.8)
                    
                    self.ActivityLoadInside.transform = CGAffineTransformConcat(forwardRotateActivityLoadingInside, zoomInActivityLoadingInside)
                    
                    
                    //Circle Loading Spin
                    //self.ActivityLoadOutSide.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
                    self.ActivityLoadInside.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                    
                    
                    }, completion: {
                        (finished) -> Void in
                        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                            //Cirlce Loading Scal
                            self.ActivityLoadOutSide.transform = CGAffineTransformMakeScale(0.8, 0.8)
                            self.ActivityLoadInside.transform = CGAffineTransformMakeScale(1, 1)
                            }, completion: {
                                (finished)-> Void in
                                self.loadingActivity()
                        })
                })
            } else {
                if DataManager.PostData.count > 0 {
                    UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                        self.ActivityLoadOutSide.transform = CGAffineTransformRotate(self.ActivityLoadOutSide.transform, CGFloat(-M_PI_2))
                        self.ActivityLoadInside.transform = CGAffineTransformRotate(self.ActivityLoadInside.transform, CGFloat(M_PI_2))
                        self.loadingView.alpha = 0
                        self.menuButton.enabled = true
                        self.AddPostButton.enabled =  true
                        }, completion: nil)
                }
            }
        }
    }
    
    func startLoadingActivity(){
        animateActivity = true
    }
    
    func stopLoadingActivity(){
        animateActivity = false
    }
    
    /*****************************************************************
    * NO DATA VIEW
    *****************************************************************/
    
    //No Data Outlets
    @IBOutlet weak var noDataMessage: UITextView!
    @IBOutlet weak var noDataRefreshButton: UIButton!
    
    //No Data Message Settings
    func setupNoDataMessage(){
        
        self.noDataRefreshButton.layer.cornerRadius = 3
        //self.noDataRefreshButton.alpha = 0
        self.noDataRefreshButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.noDataRefreshButton.layer.shadowOpacity = 0.1
        self.noDataRefreshButton.layer.shadowRadius = 2
        self.noDataRefreshButton.layer.shadowOffset = CGSizeMake(0, 1)
        
        self.noDataRefreshButton.layer.borderColor = UIColor(red: 68/255, green: 75/255, blue: 110/255, alpha: 0.2).CGColor
        self.noDataRefreshButton.layer.borderWidth = 0.5
        
        self.noDataRefreshButton.layer.masksToBounds = false
        
    }
    
    func showNoDataMessage(){
        
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.animateActivity = false
            self.ActivityLoadInside.alpha = 0
            self.ActivityLoadOutSide.alpha = 0
            self.menuButton.enabled = true
            self.AddPostButton.enabled = true
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                self.loadingView.alpha = 1
                self.noDataMessage.alpha = 1
                self.noDataRefreshButton.alpha = 1
                }, completion: nil)
        }
    }
    
    func hideNoDataMessage(){
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.noDataMessage.alpha = 0
            self.noDataRefreshButton.alpha = 0
            UIView.transitionWithView(self.loadingView, duration: 0.2, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                self.ActivityLoadInside.alpha = 1
                self.ActivityLoadOutSide.alpha = 1
                }, completion: nil)
        }
    }
    
    @IBAction func refreshNoData(sender: AnyObject) {
        self.hideNoDataMessage()
        self.performLoadData()
    }

    /*****************************************************************
    * COMPOSE
    *****************************************************************/

    //String for Location in City and State/Previonce
    var LocationInString: String?
    
    //Compose Send 
    func sendCompose(ActionToPerform: AnyObject) {
        
        /*****************************************************************
        * COMPOSE PHOTO WITH TEXT
        *****************************************************************/
        if composeView.SelectedImage.image != nil {
            
            //Image Data
            let imageData: NSData = UIImageJPEGRepresentation(composeView.SelectedImage.image!, 0.4)!
        
            //Send Post Method to Server with Image Data
            Alamofire.upload( .POST, "http://vilvas.com/test/posts.php", multipartFormData: { multipartFormData in
                
                    //Add Paramters
                    multipartFormData.appendBodyPart(data: self.USERID.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"user")
                    multipartFormData.appendBodyPart(data: "0".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"type")
                    multipartFormData.appendBodyPart(data: self.composeView.PostTextField.text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"status")
                    multipartFormData.appendBodyPart(data: self.LocationInString!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"location")
                    multipartFormData.appendBodyPart(data: String(self.longitude).dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"longitude")
                    multipartFormData.appendBodyPart(data: String(self.latitude).dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"latitude")

                    //Add Image Data
                    multipartFormData.appendBodyPart(data: imageData, name: "photoFile", fileName: NSUUID().UUIDString, mimeType: "image/jpeg")
                
                }, encodingCompletion: { encodingResult in

                    //Check if Upload Completed or Not
                    switch encodingResult {
                        
                    //Compose Photo is Successful
                    case .Success(let upload, _, _):
                        upload.responseJSON { response in
                            
                                //Reset Compose
                                self.resetCompose()
                                
                                //Load New Data
                                self.performLoadData()
                            }
                            
                            //Assign Bytes to Progress Bar
                            .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                                dispatch_async(dispatch_get_main_queue()) {
                                    self.composeView.ComposeProgress.progress = Float(totalBytesWritten / totalBytesExpectedToWrite)
                                }
                            }
                        
                    case .Failure(_):
                        
                        //Notify user Compose Text Failed
                        let composeFailedAlert: UIAlertView = UIAlertView(title: "Compose Failed.", message: "Failed to compose, please try again later.", delegate: self, cancelButtonTitle: "Sure!")
                        composeFailedAlert.show()
                    }
                }
            )
        }
        
        
        /*****************************************************************
        * COMPOSE TEXT ONLY
        *****************************************************************/
        if  composeView.SelectedImage.image == nil {
            
            //Post to Send
            let composeTextParamaters = [
                "user": USERID,
                "type": "1",
                "status": composeView.PostTextField.text!,
                "location": LocationInString!,
                "longitude": longitude,
                "latitude": latitude
            ]
            
            //Send Post Method to Server
            Alamofire.request(.POST, "http://vilvas.com/test/posts.php", parameters: composeTextParamaters as? [String : AnyObject])
                
                //Assign Bytes to Progress Bar
                .progress{ bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                    dispatch_async(dispatch_get_main_queue()) {
                        self.composeView.ComposeProgress.progress = Float(totalBytesWritten / totalBytesExpectedToWrite)
                    }
                }
                
                .responseData { response in
                    //Compose Text is Successful
                    if response.result.isSuccess {
                        
                        //Reset Compose
                        self.resetCompose()
                        
                        //Load New Data
                        self.performLoadData()
                    }
                    
                    //Compose Text is Failure
                    if response.result.isFailure {
                        
                        //Notify user Compose Text Failed
                        let composeFailedAlert: UIAlertView = UIAlertView(title: "Compose Failed.", message: "Failed to compose, please try again later.", delegate: self, cancelButtonTitle: "Sure!")
                        composeFailedAlert.show()
                    }
                }
        }
    
    }
    
    //Reset Compose after Posting or Cancel
    func resetCompose(){
        dispatch_async(dispatch_get_main_queue()){
            //Show Navigation and Status Bar
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            
            //Show Extention View
            self.extensionView.hidden = false
            
            //Reset Compose View back to Normal
            self.composeCharCount.title = "250"
            self.composeView.PostTextField.text = nil
            self.composeView.SelectedImage.image = nil
            self.composeView.PostButton.enabled = false
            self.composeView.PostButton.alpha = 0.3
            self.composeView.ComposeProgress.progress = 0
            self.composeView.PostTextField.resignFirstResponder()
            
            //Remove Compose View
            self.composeTopConstarin.constant = -205
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: { (finished: Bool)-> Void in
                    self.coverView.hidden = true
            })
            
            //Show Compose New Button in Bottom
            UIView.animateWithDuration(0.4, animations: {
                self.AddPostButton.frame.offsetInPlace(dx: 0, dy: -100)
                self.scrollUpButton.frame.offsetInPlace(dx: 0, dy: -100)
            })
        }
    }
    
    
    /*****************************************************************
    * COMPOSE VIEW
    *****************************************************************/
    @IBOutlet var AccessoryView: UIToolbar!
    @IBOutlet var composeTopConstarin: NSLayoutConstraint!
    
    @IBAction func composeNew(sender: AnyObject) {
        
        //Get Current Location
        self.locManager.startUpdatingLocation()
        
        //Update UI
        dispatch_async(dispatch_get_main_queue()){
            
            //Hide Extension View
            self.extensionView.hidden = true
            
            //Hide Post Write Button
            UIView.animateWithDuration(0.4, animations: {
                self.AddPostButton.frame.offsetInPlace(dx: 0, dy: 100)
                self.scrollUpButton.frame.offsetInPlace(dx: 0, dy: 100)
            })
            
            //Hide Navigation & Statues Bar
            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Slide)
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            
            //Set Text Field Initial Settings
            self.composeView.PostTextField.textColor = UIColor.lightGrayColor()
            self.composeView.PostTextFieldPlaceHolder.text = "What's Happening?"
            self.composeView.PostTextFieldPlaceHolder.font = UIFont.systemFontOfSize(16)
            self.composeView.PostTextFieldPlaceHolder.textColor = UIColor.lightGrayColor()
            self.composeView.PostTextFieldPlaceHolder.delegate = self
            
            //Add Input Accessory to Keyboard
            self.composeView.PostTextField.inputAccessoryView = self.AccessoryView
            self.AccessoryView.removeFromSuperview()
            
            //Make Keyboard Active
            self.composeView.PostTextField.becomeFirstResponder()
            
            //Show Compose View and Animate it
            self.composeView.hidden = false
            self.coverView.hidden = false
            self.composeTopConstarin.constant = 0
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    //Cancel Compose
    func cancelCompose(ActionToPerform: AnyObject) {
        
       self.resetCompose()
    }
    
    /*****************************************************************
    * COMPOSE TEXTVIEW
    *****************************************************************/
    func textViewDidChange(textView: UITextView) {
        if self.composeView.PostTextField.textColor == UIColor.lightGrayColor() {
            self.composeView.PostTextFieldPlaceHolder.text = nil
            self.composeView.PostTextField.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if self.composeView.PostTextField.text.isEmpty {
            self.composeView.PostTextFieldPlaceHolder.text = "What's Happening?"
            self.composeView.PostTextFieldPlaceHolder.font = UIFont.systemFontOfSize(16)
            self.composeView.PostTextFieldPlaceHolder.textColor = UIColor.lightGrayColor()
        }
    }
    
    @IBOutlet var composeCharCount: UIBarButtonItem!
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        //Compose Text View Settings
        if textView == self.composeView.PostTextField {
            let CountLength = self.composeView.PostTextField.text.utf16.count - range.length
            let countToGo = 250 - CountLength
            self.composeCharCount.title = String(countToGo)
            
            if CountLength >= 5 {
                composeView.PostButton.enabled = true
                
                //Update UI
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    UIButton.animateWithDuration(0.3, animations: {
                        self.composeView.PostButton.alpha = 1
                    })
                }
                
            } else {
                self.composeView.PostButton.enabled = false
                
                //Update UI
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    UIButton.animateWithDuration(0.2, animations: {
                        self.composeView.PostButton.alpha = 0.3
                        
                    })
                }
            }
            return CountLength <= 249
        }
        
        //Report TextView Settings
        if textView == self.reportTextView {
            let CountLength = self.reportTextView.text.utf16.count - range.length
            let countToGo = 120 - CountLength
            self.reportTextCount.text = String(countToGo)
            return CountLength <= 120
        }
        
        return false
        
    }
    
    
    /*****************************************************************
    * GALLERY PHOTO
    *****************************************************************/
    
    //Photo Gallery
    @IBOutlet var PhotoGallery: UIButton!
    let imagePicker = UIImagePickerController()
    
    //Select Photo From Gallery
    @IBAction func PhotoGallery(sender: AnyObject) {
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        //Resign Post Text Field
        self.composeView.PostTextField.resignFirstResponder()
        
        //Bring Up The Gallery
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //Assign Selected Photo to Post
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            //Attched Picked Image to Compose View
            if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
                self.composeView.SelectedImage.image = pickedImage
            }
        }
        
        //Post Text Field Become Active Again
        self.composeView.PostTextField.becomeFirstResponder()
        
        //Dismiss the Gallery
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Resign Post View Dialog After Photo Cancellation
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        //Post Text Field Become Active Again
        self.composeView.PostTextField.becomeFirstResponder()
        
        //Dismiss the Gallery
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*****************************************************************
    * CAMERA VIEW
    *****************************************************************/
    @IBOutlet var SelectPhoto: UIBarButtonItem!
    @IBOutlet var Camera: CameraView!
    
    //Open Custom Camera Layer
    @IBAction func SelectPhotos(sender: AnyObject) {
        
        //Start Session
        self.Camera.captureSession.startRunning()
        
        //Resign Post Text Field First responder
        self.composeView.PostTextField.resignFirstResponder()
        
        
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            UIView.transitionWithView(self.Camera, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                self.Camera.hidden = false
                self.Camera.alpha = 1.0
                }, completion: nil)
        }
    }
    
    func AcceptImage(ActionToPerform: AnyObject) {
        
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            self.composeView.SelectedImage.image = self.Camera.imageSource
            
            self.Camera.TakePicture.enabled = true
            UIView.transitionWithView(self.view, duration: 0.5, options: UIViewAnimationOptions.CurveLinear, animations: {
                self.Camera.capturePhoto.image = nil
                self.Camera.photoOptionDialog.alpha = 0
                self.Camera.photoOptionDialog.hidden = true
                self.Camera.TakePicture.frame.offsetInPlace(dx: 0, dy: -800)
                self.Camera.cameraSettings.frame.offsetInPlace(dx: 300, dy: 0)
                
                }, completion: {
                    (finished)-> Void in
                    self.Camera.resetCamera = false
            })
            
            //Stop Session
            self.Camera.captureSession.stopRunning()
            
            UIView.transitionWithView(self.Camera, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                self.Camera.hidden = true
                self.Camera.alpha = 0
                }, completion: {
                    (finished: Bool)-> Void in
                    //PostView Become First Responder Again
                    self.composeView.PostTextField.becomeFirstResponder()
            })
        }
    }
    
    func cancelTakingPhoto(ActionToPerform: AnyObject) {
        
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            self.Camera.capturePhoto.image = nil
            self.Camera.TakePicture.enabled = true
            if self.Camera.resetCamera == true {
                self.Camera.TakePicture.frame.offsetInPlace(dx: 0, dy: -800)
                self.Camera.cameraSettings.frame.offsetInPlace(dx: 300, dy: 0)
                self.Camera.photoOptionDialog.alpha = 0
                self.Camera.photoOptionDialog.hidden = true
                self.Camera.resetCamera = false
            }
            
            //Remove Camera View and Become First Responder Again
            UIView.transitionWithView(self.Camera, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                self.Camera.hidden = true
                self.Camera.alpha = 0
                }, completion: {
                    (finished: Bool)-> Void in
                    //PostView Become First Responder Again
                    self.composeView.PostTextField.becomeFirstResponder()
            })
        }
    
        //Stop Session
        self.Camera.captureSession.stopRunning()
    }
    
    
    /*****************************************************************
     * Notify
     *****************************************************************/
    
    @IBOutlet var notifyView: UIView!
    @IBOutlet var notifyMessage: UILabel!
    
    func notifyMessage(setNotifyColor: UIColor, setTextColor: UIColor, setNotifyMessage: String){
        self.notifyView.backgroundColor = setNotifyColor
        self.notifyMessage.text = setNotifyMessage
        self.notifyMessage.textColor = setTextColor
        
        //Show Notifer
        self.notifyView.hidden = false
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                //Show Notifier Fade in
                self.notifyView.alpha = 1.0
                }, completion: {
                    (finished) -> Void in
                    let delayInSeconds = 2.0
                    let dismissTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
                    dispatch_after(dismissTime, dispatch_get_main_queue()) { () -> Void in
                        //Dismiss Notifier
                        UIView.animateWithDuration(0.4, animations: {
                            
                            //Fade Notifier
                            self.notifyView.alpha = 0
                            }, completion: {
                                (finished)-> Void in
                                
                                //Hide Notifier
                                self.notifyView.hidden = true
                        })
                    }
            })
        }
    }
}

//COMPOSE IMAGE BOUNDARY
extension NSMutableData {
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}
