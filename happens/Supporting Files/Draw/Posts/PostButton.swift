//
//  PostButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/3/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class PostButton: UIButton {
    
    
    override var highlighted: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Private methods
    
    private var shouldHighlight: Bool {
        return highlighted || !enabled
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        drawWritePost(writeHighlighted: shouldHighlight)
    }
    
    
    func drawWritePost(writeHighlighted writeHighlighted: Bool) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let primary = UIColor(red: 0.173, green: 0.243, blue: 0.314, alpha: 1.000)
        let primaryHighlighted = UIColor(red: 0.260, green: 0.344, blue: 0.413, alpha: 0.683)
        let cloud = UIColor(red: 0.897, green: 0.902, blue: 0.903, alpha: 1.000)
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.27)
        shadow.shadowOffset = CGSizeMake(1.1, 1.1)
        shadow.shadowBlurRadius = 1
        
        //// Circle Drawing
        let circlePath = UIBezierPath(ovalInRect: CGRectMake(2, 2, 46, 46))
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        primary.setFill()
        circlePath.fill()
        CGContextRestoreGState(context)
        
        
        
        if (writeHighlighted) {
            //// Circle 2 Drawing
            let circle2Path = UIBezierPath(ovalInRect: CGRectMake(2, 2, 46, 46))
            primaryHighlighted.setFill()
            circle2Path.fill()
        }
        
        
        //// Horizontal Line Drawing
        let horizontalLinePath = UIBezierPath()
        horizontalLinePath.moveToPoint(CGPointMake(24.5, 14.5))
        horizontalLinePath.addLineToPoint(CGPointMake(24.5, 34.5))
        horizontalLinePath.lineCapStyle = CGLineCap.Square;
        
        horizontalLinePath.lineJoinStyle = CGLineJoin.Round;
        
        cloud.setStroke()
        horizontalLinePath.lineWidth = 3
        horizontalLinePath.stroke()
        
        
        //// Vertical Line Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, -15, 25)
        CGContextRotateCTM(context, 90 * CGFloat(M_PI) / 180)
        
        let verticalLinePath = UIBezierPath()
        verticalLinePath.moveToPoint(CGPointMake(-0, -30))
        verticalLinePath.addLineToPoint(CGPointMake(-0, -50))
        verticalLinePath.lineCapStyle = CGLineCap.Square;
        
        cloud.setStroke()
        verticalLinePath.lineWidth = 3
        verticalLinePath.stroke()
        
        CGContextRestoreGState(context)
    }
    

}
