//
//  CellDeleteButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/26/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class CellDeleteButton: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawCellDeleteButton(frame: self.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frame = self.bounds
    }
    
    func drawCellDeleteButton(frame frame: CGRect) {
        //// Color Declarations
        let fillColor6 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let color22 = UIColor(red: 0.966, green: 0.355, blue: 0.355, alpha: 1.000)
        
        
        //// Subframes
        let group: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.00000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5))
        
        
        //// Group
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(group.minX + floor(group.width * 0.00000 + 0.5), group.minY + floor(group.height * 0.00000 + 0.5), floor(group.width * 1.00000 + 0.5) - floor(group.width * 0.00000 + 0.5), floor(group.height * 1.00000 + 0.5) - floor(group.height * 0.00000 + 0.5)))
        color22.setFill()
        rectanglePath.fill()
        
        
        //// Shape Drawing
        let shapePath = UIBezierPath()
        shapePath.moveToPoint(CGPointMake(group.minX + 0.38571 * group.width, group.minY + 0.62870 * group.height))
        shapePath.addCurveToPoint(CGPointMake(group.minX + 0.42381 * group.width, group.minY + 0.66667 * group.height), controlPoint1: CGPointMake(group.minX + 0.38571 * group.width, group.minY + 0.64958 * group.height), controlPoint2: CGPointMake(group.minX + 0.40286 * group.width, group.minY + 0.66667 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.57619 * group.width, group.minY + 0.66667 * group.height))
        shapePath.addCurveToPoint(CGPointMake(group.minX + 0.61429 * group.width, group.minY + 0.62870 * group.height), controlPoint1: CGPointMake(group.minX + 0.59714 * group.width, group.minY + 0.66667 * group.height), controlPoint2: CGPointMake(group.minX + 0.61429 * group.width, group.minY + 0.64958 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.61429 * group.width, group.minY + 0.40093 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.38571 * group.width, group.minY + 0.40093 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.38571 * group.width, group.minY + 0.62870 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.38571 * group.width, group.minY + 0.62870 * group.height))
        shapePath.closePath()
        shapePath.moveToPoint(CGPointMake(group.minX + 0.63333 * group.width, group.minY + 0.34398 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.56667 * group.width, group.minY + 0.34398 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.54762 * group.width, group.minY + 0.32500 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.45238 * group.width, group.minY + 0.32500 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.43333 * group.width, group.minY + 0.34398 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.36667 * group.width, group.minY + 0.34398 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.36667 * group.width, group.minY + 0.38194 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.63333 * group.width, group.minY + 0.38194 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.63333 * group.width, group.minY + 0.34398 * group.height))
        shapePath.addLineToPoint(CGPointMake(group.minX + 0.63333 * group.width, group.minY + 0.34398 * group.height))
        shapePath.closePath()
        shapePath.miterLimit = 4;
        
        shapePath.usesEvenOddFillRule = true;
        
        fillColor6.setFill()
        shapePath.fill()
    }


}
