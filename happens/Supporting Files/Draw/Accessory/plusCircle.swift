//
//  plusCircle.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/8/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class plusCircle: UIButton {


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawPlusCircle(frame: self.bounds)
    }
    
    func drawPlusCircle(frame frame: CGRect) {
        //// Color Declarations
        let primary = UIColor(red: 0.173, green: 0.243, blue: 0.314, alpha: 1.000)
        
        //// path-1 Drawing
        let path1Path = UIBezierPath()
        path1Path.moveToPoint(CGPointMake(frame.minX + 0.20612 * frame.width, frame.minY + 0.52169 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.20612 * frame.width, frame.minY + 0.47633 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.47831 * frame.width, frame.minY + 0.47633 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.47831 * frame.width, frame.minY + 0.20414 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.52367 * frame.width, frame.minY + 0.20414 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.52367 * frame.width, frame.minY + 0.47633 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.79586 * frame.width, frame.minY + 0.47633 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.79586 * frame.width, frame.minY + 0.52169 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.52367 * frame.width, frame.minY + 0.52169 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.52367 * frame.width, frame.minY + 0.79388 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.47831 * frame.width, frame.minY + 0.79388 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.47831 * frame.width, frame.minY + 0.52169 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.20612 * frame.width, frame.minY + 0.52169 * frame.height))
        path1Path.closePath()
        path1Path.moveToPoint(CGPointMake(frame.minX + 0.50099 * frame.width, frame.minY + 0.99802 * frame.height))
        path1Path.addCurveToPoint(CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.49901 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77658 * frame.width, frame.minY + 0.99802 * frame.height), controlPoint2: CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.77461 * frame.height))
        path1Path.addCurveToPoint(CGPointMake(frame.minX + 0.50099 * frame.width, frame.minY + -0.00000 * frame.height), controlPoint1: CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.22342 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77658 * frame.width, frame.minY + -0.00000 * frame.height))
        path1Path.addCurveToPoint(CGPointMake(frame.minX + 0.00198 * frame.width, frame.minY + 0.49901 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.22539 * frame.width, frame.minY + -0.00000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.00198 * frame.width, frame.minY + 0.22342 * frame.height))
        path1Path.addCurveToPoint(CGPointMake(frame.minX + 0.50099 * frame.width, frame.minY + 0.99802 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.00198 * frame.width, frame.minY + 0.77461 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.22539 * frame.width, frame.minY + 0.99802 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.50099 * frame.width, frame.minY + 0.99802 * frame.height))
        path1Path.closePath()
        path1Path.moveToPoint(CGPointMake(frame.minX + 0.50099 * frame.width, frame.minY + 0.95266 * frame.height))
        path1Path.addCurveToPoint(CGPointMake(frame.minX + 0.95464 * frame.width, frame.minY + 0.49901 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.75153 * frame.width, frame.minY + 0.95266 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.95464 * frame.width, frame.minY + 0.74955 * frame.height))
        path1Path.addCurveToPoint(CGPointMake(frame.minX + 0.50099 * frame.width, frame.minY + 0.04536 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.95464 * frame.width, frame.minY + 0.24847 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.75153 * frame.width, frame.minY + 0.04536 * frame.height))
        path1Path.addCurveToPoint(CGPointMake(frame.minX + 0.04734 * frame.width, frame.minY + 0.49901 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.25045 * frame.width, frame.minY + 0.04536 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.04734 * frame.width, frame.minY + 0.24847 * frame.height))
        path1Path.addCurveToPoint(CGPointMake(frame.minX + 0.50099 * frame.width, frame.minY + 0.95266 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.04734 * frame.width, frame.minY + 0.74955 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.25045 * frame.width, frame.minY + 0.95266 * frame.height))
        path1Path.addLineToPoint(CGPointMake(frame.minX + 0.50099 * frame.width, frame.minY + 0.95266 * frame.height))
        path1Path.closePath()
        path1Path.miterLimit = 4;
        
        path1Path.usesEvenOddFillRule = true;
        
        primary.setFill()
        path1Path.fill()
    }


}
