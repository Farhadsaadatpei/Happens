//
//  Auto.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/26/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class FlashAuto: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath()
        rectanglePath.moveToPoint(CGPointMake(4, 15))
        rectanglePath.addLineToPoint(CGPointMake(9.6, 15))
        rectanglePath.addLineToPoint(CGPointMake(11, -1))
        rectanglePath.addLineToPoint(CGPointMake(11, 0))
        rectanglePath.addLineToPoint(CGPointMake(4, 15))
        rectanglePath.closePath()
        UIColor.whiteColor().setFill()
        rectanglePath.fill()
        
        
        //// Rectangle 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 14, 27)
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
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(14, 15, 9, 9))
        UIColor.whiteColor().setStroke()
        ovalPath.lineWidth = 0.5
        ovalPath.stroke()
        
        
        //// A Drawing
        let aRect = CGRectMake(16, 17, 5, 5)
        let aTextContent = NSString(string: "A")
        let aStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        aStyle.alignment = NSTextAlignment.Center
        
        let aFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(6), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: aStyle]
        
        let aTextHeight: CGFloat = aTextContent.boundingRectWithSize(CGSizeMake(aRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: aFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, aRect);
        aTextContent.drawInRect(CGRectMake(aRect.minX, aRect.minY + (aRect.height - aTextHeight) / 2, aRect.width, aTextHeight), withAttributes: aFontAttributes)
        CGContextRestoreGState(context)

    }
    

}
