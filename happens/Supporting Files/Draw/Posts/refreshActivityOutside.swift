//
//  refreshActivityOutside.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/16/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class refreshActivityOutside: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let cloud = UIColor(red: 0.897, green: 0.902, blue: 0.903, alpha: 1.000)
        
        //// Oval Drawing
        let ovalPath = UIBezierPath()
        ovalPath.moveToPoint(CGPointMake(37, 20))
        ovalPath.addCurveToPoint(CGPointMake(20, 3), controlPoint1: CGPointMake(37, 10.61), controlPoint2: CGPointMake(29.39, 3))
        ovalPath.addCurveToPoint(CGPointMake(3, 20), controlPoint1: CGPointMake(10.61, 3), controlPoint2: CGPointMake(3, 10.61))
        ovalPath.addCurveToPoint(CGPointMake(20, 37), controlPoint1: CGPointMake(3, 29.39), controlPoint2: CGPointMake(10.61, 37))
        ovalPath.addCurveToPoint(CGPointMake(37, 20), controlPoint1: CGPointMake(29.39, 37), controlPoint2: CGPointMake(37, 29.39))
        ovalPath.closePath()
        ovalPath.lineCapStyle = CGLineCap.Round;
        
        ovalPath.lineJoinStyle = CGLineJoin.Round;
        
        cloud.setStroke()
        ovalPath.lineWidth = 4
        CGContextSaveGState(context)
        CGContextSetLineDash(context, 0, [15, 11], 2)
        ovalPath.stroke()
        CGContextRestoreGState(context)

    }
    

}
