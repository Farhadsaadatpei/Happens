//
//  FlipFront.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/26/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class FlipFront: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //// Color Declarations
        let color13 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath()
        rectanglePath.moveToPoint(CGPointMake(7.5, 21.5))
        rectanglePath.addLineToPoint(CGPointMake(17.5, 21.5))
        rectanglePath.addLineToPoint(CGPointMake(17.5, 2.5))
        rectanglePath.addLineToPoint(CGPointMake(7.5, 2.5))
        rectanglePath.addLineToPoint(CGPointMake(7.5, 21.5))
        rectanglePath.closePath()
        rectanglePath.lineCapStyle = CGLineCap.Round;
        
        rectanglePath.lineJoinStyle = CGLineJoin.Bevel;
        
        UIColor.whiteColor().setFill()
        rectanglePath.fill()
        UIColor.whiteColor().setStroke()
        rectanglePath.lineWidth = 3
        rectanglePath.stroke()
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(11, 3, 3, 3))
        color13.setFill()
        ovalPath.fill()

    }


}
