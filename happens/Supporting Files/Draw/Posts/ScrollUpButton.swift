//
//  ScrollUpButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/9/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class ScrollUpButton: UIButton {

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
        self.drawScrollUp(frame: self.bounds, slideUpHighlighted: shouldHighlight)
    }
    
    func drawScrollUp(frame frame: CGRect = CGRectMake(1, 0, 199, 200), slideUpHighlighted: Bool = true) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let primary = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let cloud = UIColor(red: 0.897, green: 0.902, blue: 0.903, alpha: 1.000)
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = primary.colorWithAlphaComponent(0.21 * CGColorGetAlpha(primary.CGColor))
        shadow.shadowOffset = CGSizeMake(0.1, 2.1)
        shadow.shadowBlurRadius = 1
        
        
        //// Subframes
        let group: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.25126 + 0.5), frame.minY + floor(frame.height * 0.25000 + 0.5), floor(frame.width * 0.75377 + 0.5) - floor(frame.width * 0.25126 + 0.5), floor(frame.height * 0.75000 + 0.5) - floor(frame.height * 0.25000 + 0.5))
        
        
        //// Group
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(group.minX + floor(group.width * 0.00000 + 0.5), group.minY + floor(group.height * 0.00000 + 0.5), floor(group.width * 1.00000 + 0.5) - floor(group.width * 0.00000 + 0.5), floor(group.height * 1.00000 + 0.5) - floor(group.height * 0.00000 + 0.5)))
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        UIColor.whiteColor().setFill()
        ovalPath.fill()
        CGContextRestoreGState(context)
        
        
        
        if (slideUpHighlighted) {
            //// Oval Highlight Drawing
            let ovalHighlightPath = UIBezierPath(ovalInRect: CGRectMake(group.minX + floor(group.width * 0.00000 + 0.5), group.minY + floor(group.height * 0.00000 + 0.5), floor(group.width * 1.00000 + 0.5) - floor(group.width * 0.00000 + 0.5), floor(group.height * 1.00000 + 0.5) - floor(group.height * 0.00000 + 0.5)))
            cloud.setFill()
            ovalHighlightPath.fill()
        }
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath()
        rectanglePath.moveToPoint(CGPointMake(group.minX + 0.31915 * group.width, group.minY + 0.63830 * group.height))
        rectanglePath.addLineToPoint(CGPointMake(group.minX + 0.68085 * group.width, group.minY + 0.63830 * group.height))
        rectanglePath.addLineToPoint(CGPointMake(group.minX + 0.48936 * group.width, group.minY + 0.34043 * group.height))
        rectanglePath.addLineToPoint(CGPointMake(group.minX + 0.31915 * group.width, group.minY + 0.63830 * group.height))
        rectanglePath.closePath()
        primary.setFill()
        rectanglePath.fill()
    }



}
