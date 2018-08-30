//
//  FlipBack.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/26/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class FlipBack: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color13 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let color15 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let color16 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
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
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(8, 3, 3, 3))
        color13.setFill()
        ovalPath.fill()
        
        
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath()
        rectangle2Path.moveToPoint(CGPointMake(9, 16))
        rectangle2Path.addLineToPoint(CGPointMake(12.2, 16))
        rectangle2Path.addLineToPoint(CGPointMake(13, 6))
        rectangle2Path.addLineToPoint(CGPointMake(13, 6.62))
        rectangle2Path.addLineToPoint(CGPointMake(9, 16))
        rectangle2Path.closePath()
        color15.setFill()
        rectangle2Path.fill()
        
        
        //// Rectangle 3 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 15, 22)
        CGContextRotateCTM(context, -180 * CGFloat(M_PI) / 180)
        
        let rectangle3Path = UIBezierPath()
        rectangle3Path.moveToPoint(CGPointMake(0, 8))
        rectangle3Path.addLineToPoint(CGPointMake(2.4, 8))
        rectangle3Path.addLineToPoint(CGPointMake(3, -0))
        rectangle3Path.addLineToPoint(CGPointMake(3, 0.5))
        rectangle3Path.addLineToPoint(CGPointMake(0, 8))
        rectangle3Path.closePath()
        color16.setFill()
        rectangle3Path.fill()
        
        CGContextRestoreGState(context)

    }


}
