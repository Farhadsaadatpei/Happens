//
//  Info.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/5/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class Info: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawAboutInfo(frame: self.bounds)
    }

    
    func drawAboutInfo(frame frame: CGRect) {
        //// Color Declarations
        let primary = UIColor(red: 0.173, green: 0.243, blue: 0.314, alpha: 1.000)
        
        
        //// Subframes
        let group2: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.13175 + 0.5), frame.minY + floor(frame.height * 0.15443 - 0.3) + 0.8, floor(frame.width * 0.86825 + 0.5) - floor(frame.width * 0.13175 + 0.5), floor(frame.height * 0.84708) - floor(frame.height * 0.15443 - 0.3) - 0.3)
        
        
        //// Group 2
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(group2.minX + 0.96833 * group2.width, group2.minY + 0.47443 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.96833 * group2.width, group2.minY + 0.96473 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.03333 * group2.width, group2.minY + 0.96473 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.03333 * group2.width, group2.minY + 0.03527 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.50667 * group2.width, group2.minY + 0.03527 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.50667 * group2.width, group2.minY + 0.00000 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.00000 * group2.width, group2.minY + 0.00000 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.00000 * group2.width, group2.minY + 1.00000 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 1.00000 * group2.width, group2.minY + 1.00000 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 1.00000 * group2.width, group2.minY + 0.47443 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.96833 * group2.width, group2.minY + 0.47443 * group2.height))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        primary.setFill()
        bezierPath.fill()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(group2.minX + 0.47595 * group2.width, group2.minY + 0.28530 * group2.height))
        bezier2Path.addCurveToPoint(CGPointMake(group2.minX + 0.46095 * group2.width, group2.minY + 0.32234 * group2.height), controlPoint1: CGPointMake(group2.minX + 0.46595 * group2.width, group2.minY + 0.29589 * group2.height), controlPoint2: CGPointMake(group2.minX + 0.46095 * group2.width, group2.minY + 0.30647 * group2.height))
        bezier2Path.addCurveToPoint(CGPointMake(group2.minX + 0.47595 * group2.width, group2.minY + 0.35938 * group2.height), controlPoint1: CGPointMake(group2.minX + 0.46095 * group2.width, group2.minY + 0.33645 * group2.height), controlPoint2: CGPointMake(group2.minX + 0.46595 * group2.width, group2.minY + 0.34880 * group2.height))
        bezier2Path.addCurveToPoint(CGPointMake(group2.minX + 0.51095 * group2.width, group2.minY + 0.37525 * group2.height), controlPoint1: CGPointMake(group2.minX + 0.48595 * group2.width, group2.minY + 0.36996 * group2.height), controlPoint2: CGPointMake(group2.minX + 0.49595 * group2.width, group2.minY + 0.37525 * group2.height))
        bezier2Path.addCurveToPoint(CGPointMake(group2.minX + 0.54595 * group2.width, group2.minY + 0.35938 * group2.height), controlPoint1: CGPointMake(group2.minX + 0.52428 * group2.width, group2.minY + 0.37525 * group2.height), controlPoint2: CGPointMake(group2.minX + 0.53595 * group2.width, group2.minY + 0.36996 * group2.height))
        bezier2Path.addCurveToPoint(CGPointMake(group2.minX + 0.56095 * group2.width, group2.minY + 0.32234 * group2.height), controlPoint1: CGPointMake(group2.minX + 0.55595 * group2.width, group2.minY + 0.34880 * group2.height), controlPoint2: CGPointMake(group2.minX + 0.56095 * group2.width, group2.minY + 0.33645 * group2.height))
        bezier2Path.addCurveToPoint(CGPointMake(group2.minX + 0.54595 * group2.width, group2.minY + 0.28530 * group2.height), controlPoint1: CGPointMake(group2.minX + 0.56095 * group2.width, group2.minY + 0.30647 * group2.height), controlPoint2: CGPointMake(group2.minX + 0.55595 * group2.width, group2.minY + 0.29412 * group2.height))
        bezier2Path.addCurveToPoint(CGPointMake(group2.minX + 0.51095 * group2.width, group2.minY + 0.27119 * group2.height), controlPoint1: CGPointMake(group2.minX + 0.53595 * group2.width, group2.minY + 0.27472 * group2.height), controlPoint2: CGPointMake(group2.minX + 0.52428 * group2.width, group2.minY + 0.27119 * group2.height))
        bezier2Path.addCurveToPoint(CGPointMake(group2.minX + 0.47595 * group2.width, group2.minY + 0.28530 * group2.height), controlPoint1: CGPointMake(group2.minX + 0.49762 * group2.width, group2.minY + 0.26943 * group2.height), controlPoint2: CGPointMake(group2.minX + 0.48762 * group2.width, group2.minY + 0.27472 * group2.height))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        primary.setFill()
        bezier2Path.fill()
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(group2.minX + floor(group2.width * 0.48739 + 0.3) + 0.2, group2.minY + floor(group2.height * 0.46180 - 0.3) + 0.8, floor(group2.width * 0.53724 + 0.3) - floor(group2.width * 0.48739 + 0.3), floor(group2.height * 0.73558 - 0.1) - floor(group2.height * 0.46180 - 0.3) - 0.2))
        primary.setFill()
        rectanglePath.fill()
    }

}
