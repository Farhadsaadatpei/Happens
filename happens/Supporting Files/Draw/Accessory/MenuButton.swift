//
//  SettingsButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/4/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable public class MenuButton: UIButton {
        
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func drawRect(rect: CGRect) {
        self.drawMenu(frame: self.bounds)
    }
    
    
    var color: UIColor!
    
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }
    
    func drawMenu(frame frame: CGRect = CGRectMake(0, 0, 200, 200)) {
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.11429 * frame.width, frame.minY + 0.30800 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.88571 * frame.width, frame.minY + 0.30800 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.24400 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.92120 * frame.width, frame.minY + 0.30800 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.27933 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.88571 * frame.width, frame.minY + 0.18000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.20867 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.92120 * frame.width, frame.minY + 0.18000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.11429 * frame.width, frame.minY + 0.18000 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.24400 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.07880 * frame.width, frame.minY + 0.18000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.20867 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.11429 * frame.width, frame.minY + 0.30800 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.27933 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.07880 * frame.width, frame.minY + 0.30800 * frame.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.88571 * frame.width, frame.minY + 0.43600 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.11429 * frame.width, frame.minY + 0.43600 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.50000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.07880 * frame.width, frame.minY + 0.43600 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.46467 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.11429 * frame.width, frame.minY + 0.56400 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.53533 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.07880 * frame.width, frame.minY + 0.56400 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.88571 * frame.width, frame.minY + 0.56400 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.50000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.92120 * frame.width, frame.minY + 0.56400 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.53533 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.88571 * frame.width, frame.minY + 0.43600 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.46467 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.92120 * frame.width, frame.minY + 0.43600 * frame.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.88571 * frame.width, frame.minY + 0.69200 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.11429 * frame.width, frame.minY + 0.69200 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.75600 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.07880 * frame.width, frame.minY + 0.69200 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.72067 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.11429 * frame.width, frame.minY + 0.82000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.79133 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.07880 * frame.width, frame.minY + 0.82000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.88571 * frame.width, frame.minY + 0.82000 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.75600 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.92120 * frame.width, frame.minY + 0.82000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.79133 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.88571 * frame.width, frame.minY + 0.69200 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.72067 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.92120 * frame.width, frame.minY + 0.69200 * frame.height))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        color.setFill()
        bezierPath.fill()
    }



}
