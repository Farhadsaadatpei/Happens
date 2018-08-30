//
//  Sort.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/5/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class Sort: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawSortSetting(frame: self.bounds)
    }

    
    func drawSortSetting(frame frame: CGRect) {
        //// Color Declarations
        let primary = UIColor(red: 0.173, green: 0.243, blue: 0.314, alpha: 1.000)
        
        
        //// Subframes
        let page1: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.15957 + 0.5), frame.minY + floor(frame.height * 0.29574 + 0.5), floor(frame.width * 0.84681 + 0.5) - floor(frame.width * 0.15957 + 0.5), floor(frame.height * 0.75532 + 0.5) - floor(frame.height * 0.29574 + 0.5))
        
        
        //// Page-1
        //// Core
        //// sort
        //// Shape Drawing
        let shapePath = UIBezierPath()
        shapePath.moveToPoint(CGPointMake(page1.minX + 0.00000 * page1.width, page1.minY + 1.00000 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.33333 * page1.width, page1.minY + 1.00000 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.33333 * page1.width, page1.minY + 0.83333 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.00000 * page1.width, page1.minY + 0.83333 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.00000 * page1.width, page1.minY + 1.00000 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.00000 * page1.width, page1.minY + 1.00000 * page1.height))
        shapePath.closePath()
        shapePath.moveToPoint(CGPointMake(page1.minX + 0.00000 * page1.width, page1.minY + 0.00000 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.00000 * page1.width, page1.minY + 0.16667 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 1.00000 * page1.width, page1.minY + 0.16667 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 1.00000 * page1.width, page1.minY + 0.00000 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.00000 * page1.width, page1.minY + 0.00000 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.00000 * page1.width, page1.minY + 0.00000 * page1.height))
        shapePath.closePath()
        shapePath.moveToPoint(CGPointMake(page1.minX + 0.00000 * page1.width, page1.minY + 0.58333 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.66667 * page1.width, page1.minY + 0.58333 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.66667 * page1.width, page1.minY + 0.41667 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.00000 * page1.width, page1.minY + 0.41667 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.00000 * page1.width, page1.minY + 0.58333 * page1.height))
        shapePath.addLineToPoint(CGPointMake(page1.minX + 0.00000 * page1.width, page1.minY + 0.58333 * page1.height))
        shapePath.closePath()
        shapePath.miterLimit = 4;
        
        shapePath.usesEvenOddFillRule = true;
        
        primary.setFill()
        shapePath.fill()
    }


}
