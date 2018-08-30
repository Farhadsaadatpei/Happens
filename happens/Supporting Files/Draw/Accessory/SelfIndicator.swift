//
//  ChatSelfIndicator.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/29/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class SelfIndicator: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    var color: UIColor!
    
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }
    
    override func drawRect(rect: CGRect) {
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, 8, 8))
        color.setFill()
        ovalPath.fill()

    }


}
