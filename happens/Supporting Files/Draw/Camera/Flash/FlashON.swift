//
//  ON.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/26/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable  class FlashON: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath()
        rectanglePath.moveToPoint(CGPointMake(8, 15))
        rectanglePath.addLineToPoint(CGPointMake(13.6, 15))
        rectanglePath.addLineToPoint(CGPointMake(15, -1))
        rectanglePath.addLineToPoint(CGPointMake(15, 0))
        rectanglePath.addLineToPoint(CGPointMake(8, 15))
        rectanglePath.closePath()
        UIColor.whiteColor().setFill()
        rectanglePath.fill()
        
        
        //// Rectangle 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 18, 27)
        CGContextRotateCTM(context, -180 * CGFloat(M_PI) / 180)
        
        let rectangle2Path = UIBezierPath()
        rectangle2Path.moveToPoint(CGPointMake(0, 16))
        rectangle2Path.addLineToPoint(CGPointMake(5.6, 16))
        rectangle2Path.addLineToPoint(CGPointMake(7, 0))
        rectangle2Path.addLineToPoint(CGPointMake(7, 1))
        rectangle2Path.addLineToPoint(CGPointMake(0, 16))
        rectangle2Path.closePath()
        UIColor.whiteColor().setFill()
        rectangle2Path.fill()
        
        CGContextRestoreGState(context)

    }


}
