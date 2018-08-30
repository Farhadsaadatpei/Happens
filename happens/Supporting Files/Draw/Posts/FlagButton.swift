//
//  FlagButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/21/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class FlagButton: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawFlag(frame: self.bounds) 
    }

    var color: UIColor!
    
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }
    
    func drawFlag(frame frame: CGRect = CGRectMake(0, 0, 50, 50)) {
        //// Color Declarations
        let fillColor10 = color
        
        
        //// Subframes
        let iconsWithNumbers: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.26000 + 0.5), frame.minY + floor(frame.height * 0.18000 + 0.5), floor(frame.width * 0.74000 + 0.5) - floor(frame.width * 0.26000 + 0.5), floor(frame.height * 0.80000 + 0.5) - floor(frame.height * 0.18000 + 0.5))
        
        
        //// Icons with numbers
        //// Group 5
        //// Rectangle 307 Drawing
        let rectangle307Path = UIBezierPath()
        rectangle307Path.moveToPoint(CGPointMake(iconsWithNumbers.minX + 0.00000 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.00000 * iconsWithNumbers.height))
        rectangle307Path.addLineToPoint(CGPointMake(iconsWithNumbers.minX + 0.08333 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.00000 * iconsWithNumbers.height))
        rectangle307Path.addLineToPoint(CGPointMake(iconsWithNumbers.minX + 0.08333 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.06520 * iconsWithNumbers.height))
        rectangle307Path.addCurveToPoint(CGPointMake(iconsWithNumbers.minX + 0.50000 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.12575 * iconsWithNumbers.height), controlPoint1: CGPointMake(iconsWithNumbers.minX + 0.15440 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.09133 * iconsWithNumbers.height), controlPoint2: CGPointMake(iconsWithNumbers.minX + 0.28111 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.12575 * iconsWithNumbers.height))
        rectangle307Path.addCurveToPoint(CGPointMake(iconsWithNumbers.minX + 1.00000 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.25000 * iconsWithNumbers.height), controlPoint1: CGPointMake(iconsWithNumbers.minX + 0.91839 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.12575 * iconsWithNumbers.height), controlPoint2: CGPointMake(iconsWithNumbers.minX + 1.00000 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.25000 * iconsWithNumbers.height))
        rectangle307Path.addLineToPoint(CGPointMake(iconsWithNumbers.minX + 1.00000 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.68750 * iconsWithNumbers.height))
        rectangle307Path.addCurveToPoint(CGPointMake(iconsWithNumbers.minX + 0.50000 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.62634 * iconsWithNumbers.height), controlPoint1: CGPointMake(iconsWithNumbers.minX + 1.00000 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.68750 * iconsWithNumbers.height), controlPoint2: CGPointMake(iconsWithNumbers.minX + 0.91816 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.62634 * iconsWithNumbers.height))
        rectangle307Path.addCurveToPoint(CGPointMake(iconsWithNumbers.minX + 0.08333 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.55875 * iconsWithNumbers.height), controlPoint1: CGPointMake(iconsWithNumbers.minX + 0.28115 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.62634 * iconsWithNumbers.height), controlPoint2: CGPointMake(iconsWithNumbers.minX + 0.15442 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.59174 * iconsWithNumbers.height))
        rectangle307Path.addLineToPoint(CGPointMake(iconsWithNumbers.minX + 0.08333 * iconsWithNumbers.width, iconsWithNumbers.minY + 1.00000 * iconsWithNumbers.height))
        rectangle307Path.addLineToPoint(CGPointMake(iconsWithNumbers.minX + 0.00000 * iconsWithNumbers.width, iconsWithNumbers.minY + 1.00000 * iconsWithNumbers.height))
        rectangle307Path.addLineToPoint(CGPointMake(iconsWithNumbers.minX + 0.00000 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.50000 * iconsWithNumbers.height))
        rectangle307Path.addLineToPoint(CGPointMake(iconsWithNumbers.minX + 0.00000 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.04677 * iconsWithNumbers.height))
        rectangle307Path.addLineToPoint(CGPointMake(iconsWithNumbers.minX + 0.00000 * iconsWithNumbers.width, iconsWithNumbers.minY + 0.00000 * iconsWithNumbers.height))
        rectangle307Path.closePath()
        rectangle307Path.miterLimit = 4;
        
        rectangle307Path.usesEvenOddFillRule = true;
        
        fillColor10.setFill()
        rectangle307Path.fill()
    }




}
