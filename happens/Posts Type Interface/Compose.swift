//
//  NormalPost.swift
//  happens
//
//  Created by Vilvas, Inc. on 7/13/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@objc protocol ComposeDelegate:  class {
    optional func cancelCompose(ActionToPerform: AnyObject)
    optional func sendCompose(ActionToPerform: AnyObject)
}

@IBDesignable class Compose: UIView, UITextViewDelegate {
    
    var view: UIView!
    var nibName: String = "Compose"
    
    var delegate: ComposeDelegate?
    
    @IBOutlet weak var PostTextField: UITextView!
    @IBOutlet var PostTextFieldPlaceHolder: UITextView!
    @IBOutlet weak var PostButton: UIButton!
    @IBOutlet var SelectedImage: UIImageView!
    @IBOutlet var ComposeProgress: UIProgressView!
    @IBAction func Cancel(sender: AnyObject) {
        let ActionToPerform = sender
        self.delegate?.cancelCompose!(ActionToPerform)
    }
    
    @IBAction func Post(sender: AnyObject) {
        let ActionToPerform = sender
        self.delegate?.sendCompose!(ActionToPerform)
    }
    
    override init(frame: CGRect) {
        // properties
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // properties
        super.init(coder: aDecoder)
        
        // Set anything that uses the view or visible bounds
        setup()
    }
    
    func setup() {
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        
        //Inset Compose Text Field
        PostTextField.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8)
        PostTextFieldPlaceHolder.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8)
        PostTextField.delegate = self
        
        //Disable Compose Button Start
        PostButton.enabled = false
        
        //Change Progress Bar hight
        self.ComposeProgress.transform = CGAffineTransformMakeScale(1.0, 3.0)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
}
