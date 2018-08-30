//
//  BackButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/7/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class BackButton: UIButton {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawBack(frame: self.bounds)
    }

    
    
    func drawBack(frame frame: CGRect) {
        //// Color Declarations
        let fillColor3 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.72415 * frame.width, frame.minY + 1.00000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.77053 * frame.width, frame.minY + 0.95312 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.32222 * frame.width, frame.minY + 0.50000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.77053 * frame.width, frame.minY + 0.04688 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.72415 * frame.width, frame.minY + 0.00000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.22947 * frame.width, frame.minY + 0.50000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.72415 * frame.width, frame.minY + 1.00000 * frame.height))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        fillColor3.setFill()
        bezierPath.fill()
    }



}
