//
//  CloudView.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/12/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class CloudView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawCloudy(frame: self.bounds)
    }
 
    
    var color: UIColor!
    
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }

    
    func drawCloudy(frame frame: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let primary = color
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = primary.colorWithAlphaComponent(0.21)
        shadow.shadowOffset = CGSizeMake(0.1, 2.1)
        shadow.shadowBlurRadius = 1
        
        //// cloud 2 Drawing
        let cloud2Path = UIBezierPath()
        cloud2Path.moveToPoint(CGPointMake(frame.minX + 0.88455 * frame.width, frame.minY + 0.45829 * frame.height))
        cloud2Path.addCurveToPoint(CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.62868 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.95234 * frame.width, frame.minY + 0.48561 * frame.height), controlPoint2: CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.55160 * frame.height))
        cloud2Path.addCurveToPoint(CGPointMake(frame.minX + 0.81484 * frame.width, frame.minY + 0.81250 * frame.height), controlPoint1: CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.72999 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.91710 * frame.width, frame.minY + 0.81250 * frame.height))
        cloud2Path.addLineToPoint(CGPointMake(frame.minX + 0.18516 * frame.width, frame.minY + 0.81250 * frame.height))
        cloud2Path.addCurveToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.62868 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.08268 * frame.width, frame.minY + 0.81250 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.73020 * frame.height))
        cloud2Path.addCurveToPoint(CGPointMake(frame.minX + 0.11155 * frame.width, frame.minY + 0.45998 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.55328 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.04591 * frame.width, frame.minY + 0.48829 * frame.height))
        cloud2Path.addLineToPoint(CGPointMake(frame.minX + 0.11155 * frame.width, frame.minY + 0.45998 * frame.height))
        cloud2Path.addCurveToPoint(CGPointMake(frame.minX + 0.11111 * frame.width, frame.minY + 0.44485 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.11126 * frame.width, frame.minY + 0.45498 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.11111 * frame.width, frame.minY + 0.44993 * frame.height))
        cloud2Path.addCurveToPoint(CGPointMake(frame.minX + 0.37037 * frame.width, frame.minY + 0.18750 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.11111 * frame.width, frame.minY + 0.30272 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.22719 * frame.width, frame.minY + 0.18750 * frame.height))
        cloud2Path.addCurveToPoint(CGPointMake(frame.minX + 0.59607 * frame.width, frame.minY + 0.31812 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.46714 * frame.width, frame.minY + 0.18750 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.55153 * frame.width, frame.minY + 0.24013 * frame.height))
        cloud2Path.addCurveToPoint(CGPointMake(frame.minX + 0.68519 * frame.width, frame.minY + 0.29779 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.62299 * frame.width, frame.minY + 0.30510 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65323 * frame.width, frame.minY + 0.29779 * frame.height))
        cloud2Path.addCurveToPoint(CGPointMake(frame.minX + 0.88455 * frame.width, frame.minY + 0.45829 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.78328 * frame.width, frame.minY + 0.29779 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.86519 * frame.width, frame.minY + 0.36663 * frame.height))
        cloud2Path.closePath()
        cloud2Path.miterLimit = 4;
        
        cloud2Path.usesEvenOddFillRule = true;
        
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        primary.setFill()
        cloud2Path.fill()
        CGContextRestoreGState(context)
    }



}
