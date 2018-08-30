//
//  refreshActivityInside.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/16/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class refreshActivityInside: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let cloud = UIColor(red: 0.897, green: 0.902, blue: 0.903, alpha: 1.000)
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath()
        oval2Path.moveToPoint(CGPointMake(29, 19.5))
        oval2Path.addCurveToPoint(CGPointMake(20.5, 11), controlPoint1: CGPointMake(29, 14.81), controlPoint2: CGPointMake(25.19, 11))
        oval2Path.addCurveToPoint(CGPointMake(12, 19.5), controlPoint1: CGPointMake(15.81, 11), controlPoint2: CGPointMake(12, 14.81))
        oval2Path.addCurveToPoint(CGPointMake(20.5, 28), controlPoint1: CGPointMake(12, 24.19), controlPoint2: CGPointMake(15.81, 28))
        oval2Path.addCurveToPoint(CGPointMake(29, 19.5), controlPoint1: CGPointMake(25.19, 28), controlPoint2: CGPointMake(29, 24.19))
        oval2Path.closePath()
        oval2Path.lineCapStyle = CGLineCap.Round;
        
        oval2Path.lineJoinStyle = CGLineJoin.Round;
        
        cloud.setStroke()
        oval2Path.lineWidth = 4
        CGContextSaveGState(context)
        CGContextSetLineDash(context, 0, [15, 11], 2)
        oval2Path.stroke()
        CGContextRestoreGState(context)

    }
    

}
