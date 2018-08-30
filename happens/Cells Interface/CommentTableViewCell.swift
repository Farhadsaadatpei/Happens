//
//  ChatSendTableViewCell.swift
//  happens
//
//  Created by Vilvas, Inc. on 8/17/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit


@objc protocol CommentCellDelegate:  class {
    optional func deleteButtonAction(ActionToPerform: AnyObject)
    optional func replyButtonAction(ActionToPerform: AnyObject)
    optional func flagButtonAction(ActionToPerform: AnyObject)
    
    //Public Methods
    optional func cellDidOpen(cell: UITableViewCell)
    optional func cellDidClose(cell: UITableViewCell)
}

class CommentTableViewCell: UITableViewCell {
    
    //Initials
    var kBounceValue: CGFloat = 0.0

    @IBOutlet var chatText: UITextView!
    @IBOutlet var chatSelfIndicator: UIView!
    @IBOutlet var chatTime: UILabel!
    
    //Buttons
    @IBOutlet var deleteButton: CellDeleteButton!
    @IBOutlet var replyButton: CellReplyButton!
    @IBOutlet var flagButton: CellFlagButton!
    @IBOutlet var customContentView: UIView!
    
    //Text View
    @IBOutlet var commentLeftPadding: NSLayoutConstraint!
    
    //Animation Swap Properties
    var panRecognizer: UIPanGestureRecognizer!
    var panStartPoint: CGPoint!
    var startingRightLayoutConstraintConstant: CGFloat!
    
    @IBOutlet var contentViewRightConstraint: NSLayoutConstraint!
    @IBOutlet var contentViewLeftConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Add Gesture Capability
        self.panRecognizer = UIPanGestureRecognizer(target: self, action: "panThisCell:")
        self.panRecognizer.delegate = self
        self.customContentView.addGestureRecognizer(self.panRecognizer)
    }
    
    
    var delegate: CommentCellDelegate!
    
    //Tapped Button
    @IBAction func Tappedbutton(Sender: AnyObject){
        
        //Delete Action
        if Sender as! NSObject == self.deleteButton {
            self.delegate.deleteButtonAction!(Sender)
        }
        
        //Reply Action
        if Sender as! NSObject == self.replyButton {
            self.delegate.replyButtonAction!(Sender)
        }
        
        //Flag Action
        if Sender as! NSObject == self.flagButton {
            self.delegate.flagButtonAction!(Sender)
        }
    }
    
    
    //Capture Cell Gesture
    func panThisCell(recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
            
        case UIGestureRecognizerState.Began:
            
            self.panStartPoint = recognizer.translationInView(self.customContentView)
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant
            break
            
        case UIGestureRecognizerState.Changed:
            
            let currentPoint: CGPoint = recognizer.translationInView(self.customContentView)
            let deltaX: CGFloat = currentPoint.x - self.panStartPoint.x
            
            var panningLeft: Bool! = false
            
            if currentPoint.x < self.panStartPoint.x {
                panningLeft = true
            }
            
            if self.startingRightLayoutConstraintConstant == -8 {
                if !panningLeft{
                    let constant: CGFloat = max(-deltaX, -8)
                    if constant == 0 {
                        self.resetConstraintContstantsToZero(true, notifyDelegateDidClose: false)
                    } else {
                        self.contentViewRightConstraint.constant = constant
                    }
                }else {
                    let constant: CGFloat = min(-deltaX, self.buttonTotalWidth())
                    if constant == self.buttonTotalWidth() {
                        self.setConstraintsToShowAllButtons(true, notifyDelegateDidOpen: false)
                    } else {
                        self.contentViewRightConstraint.constant = constant
                    }
                }
            } else {
                let adjustment: CGFloat = self.startingRightLayoutConstraintConstant - deltaX
                if !panningLeft {
                    let constant: CGFloat = max(adjustment, -8)
                    if constant == 0 {
                        self.resetConstraintContstantsToZero(true, notifyDelegateDidClose: false)
                    }else {
                        self.contentViewRightConstraint.constant = constant
                    }
                } else {
                    let constant: CGFloat = min(adjustment, self.buttonTotalWidth())
                    if constant == self.buttonTotalWidth() {
                        self.setConstraintsToShowAllButtons(true, notifyDelegateDidOpen: false)
                    } else {
                        self.contentViewRightConstraint.constant = constant
                    }
                }
            }
            
            self.contentViewLeftConstraint.constant = -self.contentViewRightConstraint.constant
            break
            
        case UIGestureRecognizerState.Ended:
            if self.startingRightLayoutConstraintConstant == -8{
                let halfOfButtonOne = CGRectGetWidth(self.deleteButton.frame) / 2
                if self.contentViewRightConstraint.constant >= halfOfButtonOne {
                    self.setConstraintsToShowAllButtons(true, notifyDelegateDidOpen: true)
                }else{
                    self.resetConstraintContstantsToZero(true, notifyDelegateDidClose: true)
                }
            } else {
                let buttonOnePlusHalfOfButton2 = CGRectGetWidth(self.deleteButton.frame) + (CGRectGetWidth(self.replyButton.frame)) / 2
                if self.contentViewRightConstraint.constant >= buttonOnePlusHalfOfButton2 {
                    self.setConstraintsToShowAllButtons(true, notifyDelegateDidOpen: true)
                }else {
                    self.resetConstraintContstantsToZero(true, notifyDelegateDidClose: true)
                }
            }
            break
        case UIGestureRecognizerState.Cancelled:
            
            if self.startingRightLayoutConstraintConstant == -8{
                self.resetConstraintContstantsToZero(true, notifyDelegateDidClose: true)
            }else {
                self.setConstraintsToShowAllButtons(true, notifyDelegateDidOpen: true)
            }
            
            break
        default:
            break
        }
    }
    
    //Caculate Width
    func buttonTotalWidth()-> CGFloat {
        return CGRectGetWidth(self.frame) - CGRectGetMinX(self.replyButton.frame) - 8
    }
    
    //Set Constraint
    func setConstraintsToShowAllButtons(animate: Bool, notifyDelegateDidOpen notifyDelegate: Bool){
        
        if notifyDelegate {
            self.delegate.cellDidOpen!(self)
        }
        
        if self.startingRightLayoutConstraintConstant == self.buttonTotalWidth() && self.contentViewRightConstraint.constant == self.buttonTotalWidth() {
            return
        }
        
        self.contentViewLeftConstraint.constant = -self.buttonTotalWidth() - kBounceValue
        self.contentViewRightConstraint.constant = self.buttonTotalWidth() + kBounceValue
        
        self.updateConstraintIfNeeded(animate) { (finished) -> Void in
            self.contentViewLeftConstraint.constant = -self.buttonTotalWidth()
            self.contentViewRightConstraint.constant = self.buttonTotalWidth()
            
            self.updateConstraintIfNeeded(animate, completion: { (finished) -> Void in
                self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant
            })
        }
    }
    
    //Reset Constraint
    func resetConstraintContstantsToZero(animate: Bool, notifyDelegateDidClose notifyDelegate: Bool){
        
        if notifyDelegate {
            self.delegate.cellDidClose!(self)
        }
        
        /*if self.startingRightLayoutConstraintConstant == 0 && self.contentViewRightConstraint.constant == 0 {
            return
        }*/
        
        self.contentViewRightConstraint.constant = -kBounceValue
        self.contentViewLeftConstraint.constant = kBounceValue
        
        self.updateConstraintIfNeeded(animate) { (finished) -> Void in
            
            self.contentViewRightConstraint.constant = -8
            self.contentViewLeftConstraint.constant = -8
            
            self.updateConstraintIfNeeded(animate, completion: { (finished) -> Void in
                self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant
            })
        }
    }
    
    
    //Public Delegate
    func openCell() {
        self.setConstraintsToShowAllButtons(false, notifyDelegateDidOpen: false)
    }
    
    func updateConstraintIfNeeded(animated: Bool, completion: (finished: Bool) -> Void) {
        var duration: Double = 0
        if animated {
            duration = 0.1
        }
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.layoutIfNeeded()
                }, completion: completion)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.resetConstraintContstantsToZero(false, notifyDelegateDidClose: false)
    }
    
    
    
    override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
