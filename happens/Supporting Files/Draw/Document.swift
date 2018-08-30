//
//  Document.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/5/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class Document: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        drawDocument(frame: self.bounds)
    }

    
    func drawDocument(frame frame: CGRect) {
        //// Color Declarations
        let fillColor5 = UIColor(red: 0.173, green: 0.243, blue: 0.314, alpha: 1.000)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.77602 * frame.width, frame.minY + 0.24905 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.67227 * frame.width, frame.minY + 0.14493 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66319 * frame.width, frame.minY + 0.14103 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66967 * frame.width, frame.minY + 0.14233 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.66643 * frame.width, frame.minY + 0.14103 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.29031 * frame.width, frame.minY + 0.14103 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.22222 * frame.width, frame.minY + 0.20285 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.25465 * frame.width, frame.minY + 0.14103 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.22222 * frame.width, frame.minY + 0.16706 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.22222 * frame.width, frame.minY + 0.78851 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.29031 * frame.width, frame.minY + 0.85684 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.22222 * frame.width, frame.minY + 0.82430 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.25465 * frame.width, frame.minY + 0.85684 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.71831 * frame.width, frame.minY + 0.85684 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.77991 * frame.width, frame.minY + 0.78851 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.75398 * frame.width, frame.minY + 0.85684 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77991 * frame.width, frame.minY + 0.82430 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.77991 * frame.width, frame.minY + 0.25816 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.77602 * frame.width, frame.minY + 0.24905 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77991 * frame.width, frame.minY + 0.25490 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77862 * frame.width, frame.minY + 0.25165 * frame.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.67616 * frame.width, frame.minY + 0.18528 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.73582 * frame.width, frame.minY + 0.24514 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.71182 * frame.width, frame.minY + 0.24514 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.67616 * frame.width, frame.minY + 0.20935 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.69042 * frame.width, frame.minY + 0.24514 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.67616 * frame.width, frame.minY + 0.23083 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.67616 * frame.width, frame.minY + 0.18528 * frame.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.75398 * frame.width, frame.minY + 0.78851 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.71831 * frame.width, frame.minY + 0.83081 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.75398 * frame.width, frame.minY + 0.80998 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.73971 * frame.width, frame.minY + 0.83081 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.29031 * frame.width, frame.minY + 0.83081 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.24816 * frame.width, frame.minY + 0.78851 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.26891 * frame.width, frame.minY + 0.83081 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.24816 * frame.width, frame.minY + 0.80998 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.24816 * frame.width, frame.minY + 0.20285 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.29031 * frame.width, frame.minY + 0.16706 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.24816 * frame.width, frame.minY + 0.18137 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.26891 * frame.width, frame.minY + 0.16706 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.65022 * frame.width, frame.minY + 0.16706 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.65022 * frame.width, frame.minY + 0.20935 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.71182 * frame.width, frame.minY + 0.27117 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65022 * frame.width, frame.minY + 0.24514 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.67616 * frame.width, frame.minY + 0.27117 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.75398 * frame.width, frame.minY + 0.27117 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.75398 * frame.width, frame.minY + 0.78851 * frame.height))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        fillColor5.setFill()
        bezierPath.fill()
    }




}
