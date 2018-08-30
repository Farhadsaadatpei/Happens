//
//  PopMessageView.swift
//  happens
//
//  Created by Vilvas, Inc. on 11/3/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class PopMessageView: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawPopMessage(frame: self.bounds)
    }
    
    var color: UIColor!
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }
    
    func drawPopMessage(frame frame: CGRect = CGRectMake(0, 0, 200, 200)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        
        //// Shadow Declarations
        let popMessageShadow = NSShadow()
        popMessageShadow.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.19)
        popMessageShadow.shadowOffset = CGSizeMake(1.1, 3.1)
        popMessageShadow.shadowBlurRadius = 7
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.93000 * frame.width, frame.minY + 0.19001 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.93000 * frame.width, frame.minY + 0.64500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.93000 * frame.width, frame.minY + 0.19000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.93000 * frame.width, frame.minY + 0.64500 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.58580 * frame.width, frame.minY + 0.64500 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.81000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.54811 * frame.width, frame.minY + 0.71747 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.81000 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.42080 * frame.width, frame.minY + 0.64500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.81000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.45559 * frame.width, frame.minY + 0.71747 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.07500 * frame.width, frame.minY + 0.64500 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.07500 * frame.width, frame.minY + 0.19000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.93000 * frame.width, frame.minY + 0.19000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.93000 * frame.width, frame.minY + 0.19001 * frame.height))
        bezierPath.closePath()
        bezierPath.lineJoinStyle = .Round;
        
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, popMessageShadow.shadowOffset, popMessageShadow.shadowBlurRadius, (popMessageShadow.shadowColor as! UIColor).CGColor)
        color.setFill()
        bezierPath.fill()
        CGContextRestoreGState(context)
        
        color.setStroke()
        bezierPath.lineWidth = 5
        bezierPath.stroke()
    }




}
