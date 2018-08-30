//
//  CellFlagButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/26/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class CellFlagButton: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawCellFlagButton(frame: self.bounds)
    }

    
    func drawCellFlagButton(frame frame: CGRect = CGRectMake(0, 0, 120, 120)) {
        //// Color Declarations
        let primaryHighlighted = UIColor(red: 0.425, green: 0.476, blue: 0.518, alpha: 1.000)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.00000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5)))
        primaryHighlighted.setFill()
        rectanglePath.fill()
        
        
        //// Rectangle 307 Drawing
        let rectangle307Path = UIBezierPath()
        rectangle307Path.moveToPoint(CGPointMake(frame.minX + 0.34167 * frame.width, frame.minY + 0.29167 * frame.height))
        rectangle307Path.addLineToPoint(CGPointMake(frame.minX + 0.36806 * frame.width, frame.minY + 0.29167 * frame.height))
        rectangle307Path.addLineToPoint(CGPointMake(frame.minX + 0.36806 * frame.width, frame.minY + 0.31829 * frame.height))
        rectangle307Path.addCurveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.34301 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.39056 * frame.width, frame.minY + 0.32896 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.43069 * frame.width, frame.minY + 0.34301 * frame.height))
        rectangle307Path.addCurveToPoint(CGPointMake(frame.minX + 0.65833 * frame.width, frame.minY + 0.39375 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.63249 * frame.width, frame.minY + 0.34301 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65833 * frame.width, frame.minY + 0.39375 * frame.height))
        rectangle307Path.addLineToPoint(CGPointMake(frame.minX + 0.65833 * frame.width, frame.minY + 0.57240 * frame.height))
        rectangle307Path.addCurveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.54742 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65833 * frame.width, frame.minY + 0.57240 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.63242 * frame.width, frame.minY + 0.54742 * frame.height))
        rectangle307Path.addCurveToPoint(CGPointMake(frame.minX + 0.36806 * frame.width, frame.minY + 0.51982 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.43070 * frame.width, frame.minY + 0.54742 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.39057 * frame.width, frame.minY + 0.53329 * frame.height))
        rectangle307Path.addLineToPoint(CGPointMake(frame.minX + 0.36806 * frame.width, frame.minY + 0.70000 * frame.height))
        rectangle307Path.addLineToPoint(CGPointMake(frame.minX + 0.34167 * frame.width, frame.minY + 0.70000 * frame.height))
        rectangle307Path.addLineToPoint(CGPointMake(frame.minX + 0.34167 * frame.width, frame.minY + 0.49583 * frame.height))
        rectangle307Path.addLineToPoint(CGPointMake(frame.minX + 0.34167 * frame.width, frame.minY + 0.31076 * frame.height))
        rectangle307Path.addLineToPoint(CGPointMake(frame.minX + 0.34167 * frame.width, frame.minY + 0.29167 * frame.height))
        rectangle307Path.closePath()
        rectangle307Path.miterLimit = 4;
        
        rectangle307Path.usesEvenOddFillRule = true;
        
        UIColor.whiteColor().setFill()
        rectangle307Path.fill()
    }


}
