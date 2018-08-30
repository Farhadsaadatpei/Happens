//
//  CommentsViewController.swift
//  happens
//
//  Created by Vilvas, Inc. on 8/17/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftKeychainWrapper
import SDWebImage

class CommentsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIGestureRecognizerDelegate, ComposeDelegate, NormalPostTableViewCellDelegate, CommentCellDelegate {
    
    /*****************************************************************
    * Require Variables
    *****************************************************************/
    
    //USER ID
    var USERID: String!
    
    //POST ID
    var POSTIDRECIEVED: Int!
    
    //SINGLE POST DATA
    var SinglePostData: NSMutableDictionary!
    
    //This Cover View is used when something require user attention
    @IBOutlet var coverView: UIVisualEffectView!

    /*****************************************************************
    * VIEWS
    *****************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GET USER IF FROM KEY CHAIN
        USERID = KeychainWrapper.stringForKey("USERID")!
        
        //GET POST DETAIL
        self.SinglePostData = DataManager.FindObject(POSTIDRECIEVED, inArray: DataManager.PostData)
        
        //LOAD COMMENT OF POST
        self.fetchComments()
    
        //TABLE SETUP
        self.tableSetup()
        
        //Navigation Gesture Interact
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
        //KEYBOARD SETUP
        self.keyboardSetup()
        
        //Report View
        self.reportViewSetup()
        
        self.cellsCurrentEditing = NSMutableSet()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        
        //Resign keyboard When leaving view
        self.MessageField.resignFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        //Resign Keyboard When Disappear
        self.MessageField.resignFirstResponder()
        
        //Deregister Keyboard Notification
        self.deRegisterFromKeyboardNotification()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //Register Keyboard Norification
        self.registerForKeyboardNotification()
    }
    
    /*****************************************************************
    * KEYBOARD
    *****************************************************************/
     
     //Initialzation Keyboard
    @IBOutlet var MessageView: UIView!
    @IBOutlet var MessageField: UITextView!
    @IBOutlet var AccessoryInputTextFieldHeight: NSLayoutConstraint!
    @IBOutlet var MessageCharCount: UILabel!
    
    
    //Keyboard Can become Active
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    
    //Attache InputAccessory to Keyboard
    override var inputAccessoryView: UIView? {
        get {
            return self.MessageView
        }
    }
    
    //Keyboard Inital Setup
    func keyboardSetup(){
        
        //Remove Message View
        self.MessageView.removeFromSuperview()
        
        //Messeging Text Field View Settings
        MessageField.layer.borderWidth = 1
        MessageField.layer.borderColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0).CGColor
        MessageField.layer.cornerRadius = 4
        MessageField.layer.masksToBounds = true
        
        //Initial Placeholder for Message Text View
        MessageField.text = "Write your Message..."
        MessageField.textColor = UIColor.lightGrayColor()
        
        //Message View Delegate
        MessageField.delegate = self
    }
    
    
    //Change Views accroding to user typing
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        //If is Comment Message Text Field
        if textView == MessageField {
            
            //Get current Hight
            let currentHight = textView.frame.height
            
            //Get Range of Char Typed
            let newText = (textView.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
            
            //Caculate the New Size of Acroding to Chars
            let newSize = (newText as NSString).boundingRectWithSize(CGSize(width: textView.frame.width - textView.textContainerInset.right - textView.textContainerInset.left - 10, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: textView.font as! AnyObject], context: nil)
            
            //Create a Hight based pn Char typed.
            let heightChange  = newSize.height + textView.textContainerInset.top + textView.textContainerInset.bottom + 2 - currentHight
            
            self.inputAccessoryView!.frame.size.height += heightChange
            self.AccessoryInputTextFieldHeight.constant += heightChange
            
            self.MessageField.reloadInputViews()
            
            //Count Charcters in Message Text Field
            let CountLength = self.MessageField.text.utf16.count - range.length
            let countToGo = 250 - CountLength
            self.MessageCharCount.text = String(countToGo)
            
            if CountLength >= 3 {
                
                //Button Active
                sendButton.enabled = true
                
                //Update UI
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    UIView.animateWithDuration(0.2, animations: {
                        self.sendButton.setTitleColor(UIColor(red: 138/255, green: 141/255, blue: 146/255, alpha: 1.0), forState: UIControlState.Normal)
                    })
                })
                
            } else {
                
                //Button Not Active
                self.sendButton.enabled = false
                
                //Update UI
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    UIView.animateWithDuration(0.2, animations: {
                        self.sendButton.setTitleColor(UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0), forState: UIControlState.Normal)
                    })
                })
                
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

    //Began Typing Message
    func textViewDidBeginEditing(textView: UITextView) {
        
        //Assign Input Accessory to Message Text Field
        if textView == MessageField {
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.MessageView.hidden = false
            }
            
            //Placeholder for Message Text Field End
            if MessageField.textColor == UIColor.lightGrayColor() {
                
                //Empty the Field
                MessageField.text = nil
                
                //Reset Color Back to Black
                MessageField.textColor = UIColor.blackColor()
            }
            
            MessageField.inputAccessoryView = MessageView
            
            //Activate the Keyboard
            MessageField.becomeFirstResponder()
        }
        
        if textView == reportTextView {
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.MessageView.hidden = true
            }
        }
        
    }
    
    //End Editing Message
    func textViewDidEndEditing(textView: UITextView) {
        if textView == MessageField {
            //Placeholder for Message Text Field Began if is Empty and Keyboard Resign
            if MessageField.text.isEmpty {
                
                //Put Placeholder Message Back
                MessageField.text = "Write your Message..."
                
                //Change Color to Light Gray
                MessageField.textColor = UIColor.lightGrayColor()
            }
        }
        
        if textView == reportTextView {
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.MessageView.hidden = false
            }
        }
    }
    
    
    //Register Keyboard Notification on View Appear
    func registerForKeyboardNotification(){
        
        //Register Keyboard Will be Showing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        
        //Register Keyboard Will be Hidden
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    //De-Register Keyboard Notification on View Disappear
    func deRegisterFromKeyboardNotification(){
        
        //Deregister everything
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //Initial Keyvoard Size
    var keyboardSize: CGSize!
    
    //Show Keyboard and Adjust tableView According to Keyboard
    func keyboardWasShown(aNotification: NSNotification){
        
        //Get Keyboard Information
        let info: NSDictionary = aNotification.userInfo!
        let keyboardEndFrame: NSValue = info.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        
        //Get keyboard Size
        let kbFinalSize: CGSize = keyboardEndFrame.CGRectValue().size
        
        //Assign it to Global Variable for other use
        self.keyboardSize = kbFinalSize
    }
    
    //Hide Keyboard
    func keyboardWillBeHidden(aNotification: NSNotification){
        
        let contentInset: UIEdgeInsets = UIEdgeInsetsZero
        
        // Set tableView Inset to Zero
        self.tableView.contentInset = contentInset
        
        //Set table Scroll to Zero as Well
        self.tableView.scrollIndicatorInsets = contentInset
    }
    
    
    //Dismiss Keyboard When user tap on table
    func dismissKeyboardTap(){
        
        //if is reply comment also Hide Reply Indicator
        if self.isReply == true {
            
            
            //Reset Reply Initialization
            self.isReply = false
            self.replyParent = 0
            
            //Hide Reply Indicator
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIView.transitionWithView(self.replyCommentIndicator, duration: 0.7, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                    self.replyCommentIndicator.alpha = 0
                    }, completion: {
                        (finished)-> Void in
                        
                        //Empty Cell Editing and Close All Cells Editing
                        self.closeOtherCells(close: true)
                        self.cellsCurrentEditing = []
                })
            })
        }
        
        //Dismiss the Keyboard
        self.MessageField.resignFirstResponder()
    }
    
    /*****************************************************************
    * MARK: - Table view data source
    *****************************************************************/
     
     //Initial tableView
    @IBOutlet var tableView: UITableView!
    
    //Table Settings
    func tableSetup(){
        
        //Table View Set Delegate and Datasource
        tableView.delegate = self
        tableView.dataSource = self
        
        //Dismiss Keyboard if user tap in tableView
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: "dismissKeyboardTap")
        tableView.addGestureRecognizer(dismissKeyboardTap)
        
        //Row Initial Settings
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 260
        
        //Register Cells
    
        let nibNormal = UINib(nibName: "NormalPostTableViewCell", bundle: nil)
        self.tableView.registerNib(nibNormal, forCellReuseIdentifier: "NormalPostCell")
        
        let nibPosts = UINib(nibName: "PostsTableViewCell", bundle: nil)
        self.tableView.registerNib(nibPosts, forCellReuseIdentifier: "PostsCell")
        
        let nibMap = UINib(nibName: "MapTableViewCell", bundle: nil)
        self.tableView.registerNib(nibMap, forCellReuseIdentifier: "MapCell")
        
        let nibChat = UINib(nibName: "CommentTableViewCell", bundle: nil)
        self.tableView.registerNib(nibChat, forCellReuseIdentifier: "CommentCell")
        
        let nibNoData = UINib(nibName: "NoDataAddTableViewCell", bundle: nil)
        self.tableView.registerNib(nibNoData, forCellReuseIdentifier: "noDataAdd")
    }
    
    //Number of Section in Table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        //Post, Map, Comments
        return 3
    }

    
    //Number of Rows in Each Section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
    
        //Check Which Section
        switch (section) {
            
          case 0: //Section 0 [Post]
            
            //If Post Data Available Return 1
            if self.SinglePostData != nil {
                return 1
            } else {
                return 0
            }
          
          case 1: //Section 1 [Map]
            
            //If Post Data Available Return 1 for map Also
            if self.SinglePostData != nil {
                return 1
            } else {
                return 0
            }
            
          case 2: //Section 2 [Comments]
            
            //If Comments data Available
            if loadCommentData.count > 0 {
                
                //Return number of Comments Available
                return loadCommentData.count
                
            } else {
                
                //Else Return 1 for No Comment Available Cell
                return 1
            }
            
          default: //Return 0 for Everything Else
          return 0
            
        }
    }
    
    //Return Type of Cells with there Data POST/MAP/COMMENTS
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Init the Return of Cell Type
        var returnCell: UITableViewCell!
        
        /*****************************************************************
        * SHOW POST TYPE
        *****************************************************************/
        
        //If is Section 0 [Post]
        if indexPath.section == 0 {
            
            //Check if post is Photo
            if self.SinglePostData.valueForKey("type") as! NSNumber == 0 {
                
                //Initialize Photo Post Cell
                let cell: NormalPostTableViewCell = tableView.dequeueReusableCellWithIdentifier("NormalPostCell", forIndexPath: indexPath) as! NormalPostTableViewCell
                
                //Cell Delegates
                cell.delegate = self
                
                
                /*============ SELF INDICATOR ============*/
                
                //Check if Post is self
                if self.SinglePostData.valueForKey("user") as! String == USERID{
                    
                    //If Its self return Indicator
                    cell.SelfPostIndicator.hidden = false
                    
                } else {
                    
                    //Else Hide Indicator
                    cell.SelfPostIndicator.hidden = true
                    
                }
                
                /*============ PHOTO ============*/
                
                if (self.SinglePostData.valueForKey("photoURLExtension") != nil){
                    
                    /*let imageCache: SDImageCache = SDImageCache.sharedImageCache()
                    imageCache.cleanDisk()
                    imageCache.clearMemory()*/
                    
                    dispatch_async(dispatch_get_main_queue()){
                        cell.postPhoto.hidden = false
                        //URL Ready and Extention
                        let URLExtention = self.SinglePostData.valueForKey("photoURLExtension") as! String
                        let imageURL = NSURL(string: "https://pixabay.com/\(URLExtention)")
                        
                        //Placeholder Image
                        let sdPlaceholder: UIImage = UIImage(named: "sdPlaceholder")!
                        
                        //Load Image
                        cell.postPhoto.sd_setImageWithURL(imageURL, placeholderImage: sdPlaceholder)
                        
                    }
                }
                
                /*============ STATUS ============*/
                
                cell.postStatus.text = self.SinglePostData.valueForKey("status") as? String
                cell.postStatus.font = UIFont.systemFontOfSize(15)
                cell.postStatus.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
                
                /*============ RANK ============*/
                
                if let totalVotes = self.SinglePostData.valueForKey("numberOfVotes") as? String {
                    
                    //Convert number of Votes Value to Int
                    let Formatter: NSNumberFormatter = NSNumberFormatter()
                    Formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
                    
                    let totalVotesInNumber = Int(Formatter.numberFromString(totalVotes)!)
                    
                    //Check Which Rank the Post Have
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

                }else if self.SinglePostData.valueForKey("numberOfVotes") is NSNull{
                    cell.postRankView.alpha = 0
                }
                
                /*============ VOTES / USER VOTE ============*/
                
                //Get Total Votes
                if let voteValue = self.SinglePostData.valueForKey("numberOfVotes") as? String {
                    
                    //Assign total Votes
                    cell.numberOfVotes.text = voteValue
                    
                } else if (self.SinglePostData.valueForKey("numberOfVotes") is NSNull){
                    
                    //If Total Vote is Empty Return 0
                    cell.numberOfVotes.text = "0"
                }
                
                
                //Check if user voted on this post
                if let userVoteValue = self.SinglePostData.valueForKey("userVote") as? NSNumber  {
                    
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
                
                //If User hasn't vote don't change view
                if self.SinglePostData.valueForKey("userVote") is NSNull {
                    //Up Vote
                    cell.upVoteButton.selected = false
                    cell.upVoteButton.tintColor = UIColor.lightGrayColor()
                    //Down Vote
                    cell.downVoteButton.selected = false
                    cell.downVoteButton.tintColor = UIColor.lightGrayColor()
                    
                }
                
                /*============ COMMENTS ============*/
                
                //Disable Comment Button since is post view itself.
                cell.postComment.enabled = false
                
                //Assign Total Comment
                cell.numberOfComments.text = String(self.SinglePostData.valueForKey("numberOfComments")!)
                
                /*============ LOCATION ============*/
                
                //Assign Post Location
                cell.postLocation.text = self.SinglePostData.valueForKey("location") as? String
                
                /*============ POST TIME ============*/
                
                //Convert time to UTC
                let dateFormatter = NSDateFormatter()
                dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let timeStamp = dateFormatter.dateFromString(self.SinglePostData.valueForKey("time") as! String)
                let timeToShow = NSDate().timeIntervalSinceDate(timeStamp!)
                
                //Create Prefix for Time (s)
                func getTimeData(value: NSTimeInterval) -> (count: Int, suffix: String) {
                    let count = Int(floor(value))
                    let suffix = count != 1 ? "s" : ""
                    return (count: count, suffix: suffix)
                }
                
                
                //Caculate how old is the post and Show it.
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
                
            }
            
            //Check if Post is TEXT
            if self.SinglePostData.valueForKey("type") as! NSNumber == 1 {
                
                //Return Text Cell
                let cell: PostsTableViewCell = tableView.dequeueReusableCellWithIdentifier("PostsCell", forIndexPath: indexPath) as! PostsTableViewCell
                
                //Cell Delegate
                cell.delegate = self
                
                /*============ SELF INDICATOR ============*/
                
                //Check if Post is self
                if self.SinglePostData.valueForKey("user") as! String == USERID{
                    
                    //If Its self return Indicator
                    cell.SelfPostIndicator.hidden = false
                    
                } else {
                    
                    //Else Hide Indicator
                    cell.SelfPostIndicator.hidden = true
                    
                }
                
                /*============ STATUS ============*/
                
                cell.postStatus.text = self.SinglePostData.valueForKey("status") as? String
                cell.postStatus.font = UIFont.systemFontOfSize(15)
                cell.postStatus.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
                
                /*============ RANK ============*/
                
                if let totalVotes = self.SinglePostData.valueForKey("numberOfVotes") as? String {
                    
                    //Convert number of Votes Value to Int
                    let Formatter: NSNumberFormatter = NSNumberFormatter()
                    Formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
                    
                    let totalVotesInNumber = Int(Formatter.numberFromString(totalVotes)!)
                    
                    //Check Which Rank the Post Have
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
                    
                }else if self.SinglePostData.valueForKey("numberOfVotes") is NSNull{
                    cell.postRankView.alpha = 0
                }
                
                /*============ VOTES / USER VOTE ============*/
                
                //Get Total Votes
                if let voteValue = self.SinglePostData.valueForKey("numberOfVotes") as? String {
                    
                    //Assign total Votes
                    cell.numberOfVotes.text = voteValue
                    
                } else if (self.SinglePostData.valueForKey("numberOfVotes") is NSNull){
                    
                    //If Total Vote is Empty Return 0
                    cell.numberOfVotes.text = "0"
                }
                
                
                //Check if user voted on this post
                if let userVoteValue = self.SinglePostData.valueForKey("userVote") as? NSNumber  {
                    
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
                
                //If User hasn't vote don't change view
                if self.SinglePostData.valueForKey("userVote") is NSNull {
                    //Up Vote
                    cell.upVoteButton.selected = false
                    cell.upVoteButton.tintColor = UIColor.lightGrayColor()
                    //Down Vote
                    cell.downVoteButton.selected = false
                    cell.downVoteButton.tintColor = UIColor.lightGrayColor()
                    
                }
                
                /*============ COMMENTS ============*/
                
                //Disable Comment Button since is post view itself.
                cell.postComment.enabled = false
                
                //Assign Total Comment
                cell.numberOfComments.text = String(self.SinglePostData.valueForKey("numberOfComments")!)
                
                /*============ LOCATION ============*/
                
                //Assign Post Location
                cell.postLocation.text = self.SinglePostData.valueForKey("location") as? String
                
                /*============ POST TIME ============*/
                
                //Convert time to UTC
                let dateFormatter = NSDateFormatter()
                dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let timeStamp = dateFormatter.dateFromString(self.SinglePostData.valueForKey("time") as! String)
                let timeToShow = NSDate().timeIntervalSinceDate(timeStamp!)
                
                //Create Prefix for Time (s)
                func getTimeData(value: NSTimeInterval) -> (count: Int, suffix: String) {
                    let count = Int(floor(value))
                    let suffix = count != 1 ? "s" : ""
                    return (count: count, suffix: suffix)
                }
                
                
                //Caculate how old is the post and Show it.
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
        }
        
        /*****************************************************************
        * SHOW MAP / LOCATION OF POST
        *****************************************************************/
        
        //If is Section 1 [Map]
        if indexPath.section == 1{
            
            //Return Map Cell
            let cell: MapTableViewCell = tableView.dequeueReusableCellWithIdentifier("MapCell", forIndexPath: indexPath) as! MapTableViewCell
            
            //Get Post Long and Lat from Post Data
            let latitude = self.SinglePostData.valueForKey("latitude") as! Double
            let longitude = self.SinglePostData.valueForKey("longitude") as! Double
            
            //Turn Double Value to Location Degree
            let locationLatitude: CLLocationDegrees = latitude
            let locationLongitude: CLLocationDegrees = longitude
            
            //Create A Coordinate pf Location Degree
            let location = CLLocationCoordinate2DMake(locationLatitude, locationLongitude)
            
            //Assign Location value to Map
            cell.cellMapView.centerCoordinate = location
            let region = MKCoordinateRegionMakeWithDistance(location, 4500, 4500)
            cell.cellMapView.setRegion(region, animated: true)
            
            //Return Text Cell
            returnCell = cell
            
        }
        
        /*****************************************************************
        * SHOW COMMENTS
        *****************************************************************/
        
        //If is Section 2 [Comments]
        if indexPath.section == 2{
            
            // if No Comments Available, Show No Comment Cell
            if self.loadCommentData.count == 0 {
                let cell: NoDataAddTableViewCell = tableView.dequeueReusableCellWithIdentifier("noDataAdd", forIndexPath: indexPath) as! NoDataAddTableViewCell
                cell.title.text = "Be the first to comment"
                returnCell = cell
            }
            
            //If Comment Exist Show Comments
            if self.loadCommentData.count > 0 {
                //Show Comments
                if (loadCommentData[indexPath.row].valueForKey("parent") is NSNull) {
                    let cell: CommentTableViewCell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentTableViewCell
                    
                    cell.delegate = self
                    
                    /*----------------------------------------------------
                    //CHAT STATUS
                    ----------------------------------------------------*/
                    cell.chatText.text = loadCommentData[indexPath.row].valueForKey("comment") as! String
                    cell.chatText.font = UIFont.systemFontOfSize(14)
                    cell.chatText.textColor = UIColor(red: 39/255, green: 56/255, blue: 74/255, alpha: 1.0)
                    
                    /*----------------------------------------------------
                    //CHAT SELF INDICATOR
                    ----------------------------------------------------*/
                    if loadCommentData[indexPath.row].valueForKey("user") as! String == USERID{
                        
                        cell.chatSelfIndicator.hidden = false
                        
                        //Hide Reply and Flag Action Buttons
                        cell.replyButton.hidden = true
                        cell.flagButton.hidden = true
                        
                    } else {
                        
                        cell.chatSelfIndicator.hidden = true
                        
                        //Hide Delete Action buttons 
                        cell.deleteButton.hidden = true
                    }
                    
                    /*----------------------------------------------------
                    //TIME FOR CHAT
                    ----------------------------------------------------*/
                    
                    //Time 0000-00-00 00:00:00 UTC
                    func getTimeData(value: NSTimeInterval) -> (count: Int, suffix: String) {
                        let count = Int(floor(value))
                        let suffix = count != 1 ? "s" : ""
                        return (count: count, suffix: suffix)
                    }
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let timeStamp = dateFormatter.dateFromString(loadCommentData[indexPath.row].valueForKey("time") as! String)
                    let timeToShow = NSDate().timeIntervalSinceDate(timeStamp!)
                    
                    switch timeToShow {
                    case 0...15:
                        cell.chatTime.text = "Now"
                    case 0..<60:
                        let timeDate = getTimeData(timeToShow)
                        cell.chatTime.text = "\(timeDate.count) s"
                        
                    case 0..<3600:
                        let timeDate = getTimeData(timeToShow/60)
                        cell.chatTime.text = "\(timeDate.count) m\(timeDate.suffix)"
                        
                    case 0..<86400:
                        let timeDate = getTimeData(timeToShow/3600)
                        cell.chatTime.text = "\(timeDate.count) hr\(timeDate.suffix)"
                        
                    case 0..<604800:
                        let timeDate = getTimeData(timeToShow/86400)
                        cell.chatTime.text = "\(timeDate.count) d\(timeDate.suffix)"
                        
                    case 0..<2419200:
                        let timeDate = getTimeData(timeToShow/604800)
                        cell.chatTime.text = "\(timeDate.count) wk\(timeDate.suffix)"
                        
                    case 0..<31536000:
                        let timeDate = getTimeData(timeToShow/2419200)
                        cell.chatTime.text = "\(timeDate.count) mo\(timeDate.suffix)"
                        
                    default:
                        let timeDate = getTimeData(timeToShow/31536000)
                        cell.chatTime.text = "\(timeDate.count) yr\(timeDate.suffix)"
                    }
                    
                    //Keep the Cell Open if is Editing
                    /*if self.cellsCurrentEditing.containsObject(indexPath){
                        cell.openCell()
                    }*/
                    
                    returnCell = cell
                }
            
                if !(loadCommentData[indexPath.row].valueForKey("parent") is NSNull) {
                    let cell: CommentTableViewCell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentTableViewCell
                    
                    cell.delegate = self
                    
                    
                    //Padd Left Cause this is child Comment
                    cell.commentLeftPadding.constant = 35
                    
                    /*----------------------------------------------------
                    //CHAT STATUS
                    ----------------------------------------------------*/
                    cell.chatText.text = loadCommentData[indexPath.row].valueForKey("comment") as! String
                    cell.chatText.font = UIFont.systemFontOfSize(14)
                    cell.chatText.textColor = UIColor(red: 39/255, green: 56/255, blue: 74/255, alpha: 1.0)
                    
                    /*----------------------------------------------------
                    //CHAT SELF INDICATOR
                    ----------------------------------------------------*/
                    if loadCommentData[indexPath.row].valueForKey("user") as! String == USERID{
                        
                        cell.chatSelfIndicator.hidden = false
                        
                        //Hide Reply and Flag Action Buttons
                        cell.replyButton.hidden = true
                        cell.flagButton.hidden = true
                        
                    } else {
                        
                        cell.chatSelfIndicator.hidden = true
                        
                        //Hide Delete Action buttons
                        cell.deleteButton.hidden = true
                    }
                    
                    /*----------------------------------------------------
                    //TIME FOR CHAT
                    ----------------------------------------------------*/
                    
                    //Time 0000-00-00 00:00:00 UTC
                    func getTimeData(value: NSTimeInterval) -> (count: Int, suffix: String) {
                        let count = Int(floor(value))
                        let suffix = count != 1 ? "s" : ""
                        return (count: count, suffix: suffix)
                    }
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let timeStamp = dateFormatter.dateFromString(loadCommentData[indexPath.row].valueForKey("time") as! String)
                    let timeToShow = NSDate().timeIntervalSinceDate(timeStamp!)
                    
                    switch timeToShow {
                    case 0...15:
                        cell.chatTime.text = "Now"
                    case 0..<60:
                        let timeDate = getTimeData(timeToShow)
                        cell.chatTime.text = "\(timeDate.count) s"
                        
                    case 0..<3600:
                        let timeDate = getTimeData(timeToShow/60)
                        cell.chatTime.text = "\(timeDate.count) m\(timeDate.suffix)"
                        
                    case 0..<86400:
                        let timeDate = getTimeData(timeToShow/3600)
                        cell.chatTime.text = "\(timeDate.count) hr\(timeDate.suffix)"
                        
                    case 0..<604800:
                        let timeDate = getTimeData(timeToShow/86400)
                        cell.chatTime.text = "\(timeDate.count) d\(timeDate.suffix)"
                        
                    case 0..<2419200:
                        let timeDate = getTimeData(timeToShow/604800)
                        cell.chatTime.text = "\(timeDate.count) wk\(timeDate.suffix)"
                        
                    case 0..<31536000:
                        let timeDate = getTimeData(timeToShow/2419200)
                        cell.chatTime.text = "\(timeDate.count) mo\(timeDate.suffix)"
                        
                    default:
                        let timeDate = getTimeData(timeToShow/31536000)
                        cell.chatTime.text = "\(timeDate.count) yr\(timeDate.suffix)"
                    }
                    
                    
                    //Keep the Cell Open if is Editing
                    /*if self.cellsCurrentEditing.containsObject(indexPath){
                        cell.openCell()
                    }*/
                    
                    returnCell = cell
                }

            }
        }
        
        return returnCell
    }
    
    
    //INITIAL CELL SELECT
    var optionsSelected: NSDictionary!
    
    //Current Cell Option
    var cellsCurrentEditing: NSMutableSet!
    var currentActiveIndexPath: NSIndexPath!
    
    //Disable Default Swipes of Table Cells
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    //Close Other Cells Once a new one open
    func closeOtherCells(close close: Bool){
        if cellsCurrentEditing != nil {
            for cells in cellsCurrentEditing {
                if cellsCurrentEditing != nil {
                    let cellToClose: CommentTableViewCell = self.tableView.cellForRowAtIndexPath(cells as! NSIndexPath) as! CommentTableViewCell
                    cellToClose.resetConstraintContstantsToZero(true, notifyDelegateDidClose: true)
                }
            }
        }
    }
    
    //Once the Cell completly open, add it to Cell Currently Editing Set
    func cellDidOpen(cell: UITableViewCell) {
        
        //Close Other Open Cells
        closeOtherCells(close: true)
        
        //Create Index of Current Editing Cell
        let indexPath: NSIndexPath = self.tableView.indexPathForCell(cell)!
        
        currentActiveIndexPath = indexPath
        
        //Get Open Cell Detail
        optionsSelected = loadCommentData[(indexPath.row)] as! NSDictionary
        
        //Add it to our Editing Set
        self.cellsCurrentEditing.addObject(indexPath)
 
    }
    
    
    //Inidicate Cell delegate is close and remove it from Cell Currently Editing Set
    func cellDidClose(cell: UITableViewCell) {
        
        //Remove it From Editing Set
        self.cellsCurrentEditing.removeObject(self.tableView.indexPathForCell(cell)!)
    }
    
    //Delete Comment
    func deleteButtonAction(ActionToPerform: AnyObject) {
        
        //Paramters to Send
        let Paramters = [
            "comment" : self.optionsSelected.valueForKey("id") as! Int,
            "user": USERID
        ]
        
        //Send to Server
        Alamofire.request(.POST, "http://vilvas.com/test/user/delete/comment.php", parameters: Paramters as? [String : AnyObject])
            .responseJSON{ response in
                switch response.result{
                case .Success(let JSON):
                    
                    //Check if Correct Comment Deleted
                    if Int(JSON.valueForKey("id") as! String) == self.optionsSelected.valueForKey("id") as? Int {
                        
                        //Find the Comment in Array by ID
                        let objectToRemoveIndex = self.loadCommentData.indexOfObjectPassingTest{ (resultFind, ind, bool) in
                            return resultFind["id"] as? Int == Int(JSON.valueForKey("id") as! String) &&
                                   resultFind["user"] as? String == JSON.valueForKey("user") as? String
                        }
                        
                        //If Data wasn't find in Array Show Error
                        if objectToRemoveIndex == NSNotFound {
                            //Notify user Fail to Delete Comments
                            self.notifyMessage(UIColor(red: 0.966, green: 0.355, blue: 0.355, alpha: 1.000), setTextColor: UIColor.whiteColor(), setNotifyMessage: "Fail to delete comment, try again.")
                            
                        } else {
                            
                            self.notifyMessage(UIColor(red: 0.966, green: 0.355, blue: 0.355, alpha: 1.000), setTextColor: UIColor.whiteColor(), setNotifyMessage: "Comment deleted")
                            
                            //Update Array and Reload table
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                //Remove Object
                                self.loadCommentData.removeObjectAtIndex(objectToRemoveIndex)
                                
                                //Empty Cell Editing and Close All Cells Editing
                                self.cellsCurrentEditing = []
                                self.closeOtherCells(close: true)
                                
                                //Reload Comments
                                self.tableView.reloadData()
                            })
                        }
                    }
                    
                case .Failure(_):
                    
                    //Notify user Fail to Delete Comments
                    self.notifyMessage(UIColor(red: 0.966, green: 0.355, blue: 0.355, alpha: 1.000), setTextColor: UIColor.whiteColor(), setNotifyMessage: "Fail to delete comment, try again.")
                }
        }
    }
    
    
    //Reply Comment
    func replyButtonAction(ActionToPerform: AnyObject) {
        
        //Make Keyboard Responder
        self.MessageField.becomeFirstResponder()
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.keyboardSize.height, 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, self.keyboardSize.height, 0)
        let indexPathToScroll: NSIndexPath = NSIndexPath(forRow: currentActiveIndexPath.row, inSection: currentActiveIndexPath.section)
        self.tableView.scrollToRowAtIndexPath(indexPathToScroll, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        self.tableView.setEditing(false, animated: true)
        
        //Indicate Replying To and Add it to TextView
        self.isReply = true
        
        //Get Parent ID
        self.replyParent = self.optionsSelected.valueForKey("id") as! Int
        
        //Show Reply Indicator
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            UIView.transitionWithView(self.replyCommentIndicator, duration: 0.7, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                self.replyCommentIndicator.alpha = 1
                }, completion: nil)
        }
    }


    //Flag Comment
    func flagButtonAction(ActionToPerform: AnyObject) {
        
        //Update UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            //Show Cover View
            self.coverView.hidden = false
        }
        
        //if user id of comment don't match show report
        if optionsSelected.valueForKey("user") as? String != USERID {
            
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
    }
    
    /*****************************************************************
     * REPORT POST
     *****************************************************************/
    
    @IBOutlet var reportView: UIView!
    @IBOutlet var reportTextView: UITextView!
    @IBOutlet var reportCommentButton: FlagButton!
    @IBOutlet var reportTextCount: UILabel!
    
    func reportViewSetup(){
        
        //Report Setting Delegates
        self.reportTextView.delegate = self
        
        //Disable Flagging on Intial
        self.reportCommentButton.enabled = false
        
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
                        self.reportCommentButton.enabled = true
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
                        self.reportCommentButton.enabled = true
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
    
    @IBAction func reportComment(sender: AnyObject) {
        
        //Parameters to Send
        let Paramater = [
            "comment": self.optionsSelected.valueForKey("id") as! Int,
            "level": reportLevel!,
            "reason": "\(reportTextView.text!) ",
            "user": USERID!
        ]
        
        //Send Request to Server
        Alamofire.request(.POST, "http://vilvas.com/test/user/flag/comment.php", parameters: Paramater as? [String : AnyObject])
            .responseJSON{ response in
                switch response.result{
                    
                case .Success(let JSON):
                    
                    if JSON.valueForKey("Status") as! String == "OK" {
                        self.notifyMessage(UIColor(red: 0.425, green: 0.476, blue: 0.518, alpha: 1.000), setTextColor: UIColor.whiteColor(), setNotifyMessage: "Comment flagged.")
                        
                        self.cancelReport(self)
                    }
                    
                case .Failure(_):
                    
                    self.notifyMessage(UIColor(red: 0.966, green: 0.355, blue: 0.355, alpha: 1.000), setTextColor: UIColor.whiteColor(), setNotifyMessage: "Fail to flag.")
                    
                    self.cancelReport(self)
                }
        }
    }
    
    @IBAction func cancelReport(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.reportView.alpha = 0
                self.reportView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0)
                }, completion: {
                    (finished) -> Void in
                    
                    //Close Cell
                    self.closeOtherCells(close: true)
                    
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
                    
                    //Report Button Disable
                    self.reportCommentButton.enabled = false
                    
                    //Hide Report View
                    self.reportView.hidden = true
                    
                    //HideCover View
                    self.coverView.hidden = true
                    
            })
        })
    }


    /*****************************************************************
     * LOAD COMMENTS DATA
     *****************************************************************/

    //Data to load with Animation Performance
    var loadCommentData: NSMutableArray! = []

    func fetchComments(){
        
        //Paramters to Send
        let Paramaters = [
            "post" : POSTIDRECIEVED
        ]
        
        //Get Comment Data From Server
        Alamofire.request(.POST, "http://vilvas.com/test/comments.php", parameters: Paramaters)
            .responseJSON{ response in
                switch response.result {
                case .Success(let JSON):
                
                    //Assign Value from Sever to Global Array
                    self.loadCommentData = JSON.mutableCopy() as! NSMutableArray
                    
                    //Reload Table After Getting Comments
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                    
                case .Failure(_):
                    //Notify user Fail to Get Comments
                    self.notifyMessage(UIColor(red: 0.966, green: 0.355, blue: 0.355, alpha: 1.000), setTextColor: UIColor.whiteColor(), setNotifyMessage: "Fail to load comments, try again.")
                }
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
    * SEND COMMENT / REPLY
    *****************************************************************/
    
    @IBOutlet var replyCommentIndicator: UIView!
    @IBOutlet var sendButton: UIButton!
    
     //Indicate if Comment is Reply
    var isReply: Bool! = false
    var replyParent: Int! = 0
    
    @IBAction func SendMessage(sender: AnyObject) {
        
        //Check if User data is nil, if so Show Error
        if USERID == nil{
            let alertController = UIAlertController(title: "Credentials", message:
                "We can't recognize your credentials, please refresh app and try again.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        /*=====SEND REGULAR MESSAGE======*/
        
        if isReply == false {
            
            //Paramter to Send
            let Paramters = [
                "post" : self.SinglePostData.valueForKey("id") as! NSNumber,
                "user" : self.USERID,
                "comment" : self.MessageField.text
            ]
            
            //Send Message to Server
            Alamofire.request(.POST, "http://vilvas.com/test/comments.php", parameters: Paramters)
                .responseJSON{ response in
                    switch response.result {
                        
                        //If Successfully Send Message
                    case .Success(let JSON):
                        
                        //GET New Array of Comments
                        self.loadCommentData = JSON.mutableCopy() as! NSMutableArray
                        
                        //Reload Table
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.tableView.reloadData()
                        })
                        
                        //If Faild to Comment Show error
                    case .Failure(_):
                        //Notify User
                        self.notifyMessage(UIColor(red: 0.966, green: 0.355, blue: 0.355, alpha: 1.000), setTextColor: UIColor.whiteColor(), setNotifyMessage: "Fail to comment, try again.")
                    }
            }
        }
        
        /*=====SEND REPLY MESSAGE======*/
        
        if isReply == true && replyParent != 0{
            
            //Paramter to Send
            let Paramters = [
                "post" : self.SinglePostData.valueForKey("id") as! NSNumber,
                "parent" : replyParent,
                "user" : self.USERID,
                "comment" : self.MessageField.text
            ]
            
            //Send Message to Server
            Alamofire.request(.POST, "http://vilvas.com/test/comments.php", parameters: Paramters)
                .responseJSON{ response in
                    switch response.result {
                        
                        //If Successfully Send Message
                    case .Success(let JSON):
                        
                        //GET New Array of Comments
                        self.loadCommentData = JSON.mutableCopy() as! NSMutableArray
                        
                        //Reload Table
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.tableView.reloadData()
                        })
                        
                        //If Faild to Comment Show error
                    case .Failure(_):
                        //Notify User
                        self.notifyMessage(UIColor(red: 0.966, green: 0.355, blue: 0.355, alpha: 1.000), setTextColor: UIColor.whiteColor(), setNotifyMessage: "Fail to delete comment, try again.")
                    }
            }
        }
        
        //Set Keyboard to default and Empty Parent ID
        if self.isReply == true {
            //Dismiss Reply Comment Indicator
            self.isReply = false
            self.replyParent = 0
            
            //Update UI
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIView.transitionWithView(self.replyCommentIndicator, duration: 0.7, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                    self.replyCommentIndicator.alpha = 0
                    }, completion: nil)
            })
        }
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            //Empty Cell Editing and Close All Cells Editing
            self.closeOtherCells(close: true)
            self.cellsCurrentEditing = []
        }
        
        MessageField.text = ""
        MessageField.resignFirstResponder()
        
    }
    
    //Cancel Reply Message
    @IBAction func cancelReply(sender: AnyObject) {
        if self.isReply == true {
            //Dismiss Reply Comment Indicator
            self.isReply = false
            self.replyParent = 0
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIView.transitionWithView(self.replyCommentIndicator, duration: 0.7, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                    self.replyCommentIndicator.alpha = 0
                    }, completion: {
                        (finished)-> Void in
                        
                        //Empty Cell Editing and Close All Cells Editing
                        self.closeOtherCells(close: true)
                        self.cellsCurrentEditing = []
                })
            })
        }
        self.MessageField.resignFirstResponder()
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


