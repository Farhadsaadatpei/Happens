//
//  LogoButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/4/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class LogoButton: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawLogo(frame: self.bounds)
    }
    
    
    func drawLogo(frame frame: CGRect) {
        
        
        //// Subframes
        let logooutlinesvgGroup: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.18386 - 0.39) + 0.89, frame.minY + floor(frame.height * 0.13465 - 0.17) + 0.67, floor(frame.width * 0.80429 - 0.33) - floor(frame.width * 0.18386 - 0.39) - 0.06, floor(frame.height * 0.88001 + 0.18) - floor(frame.height * 0.13465 - 0.17) - 0.35)
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(-103, 101, 91, 13))
        UIColor.grayColor().setFill()
        rectanglePath.fill()
        
        
        //// Logo-outline.svg Group
        //// Middle_Circle
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(logooutlinesvgGroup.minX + floor(logooutlinesvgGroup.width * 0.28213 + 0.02) + 0.48, logooutlinesvgGroup.minY + floor(logooutlinesvgGroup.height * 0.62472 + 0.21) + 0.29, floor(logooutlinesvgGroup.width * 0.47758 - 0.43) - floor(logooutlinesvgGroup.width * 0.28213 + 0.02) + 0.45, floor(logooutlinesvgGroup.height * 0.78959 - 0.25) - floor(logooutlinesvgGroup.height * 0.62472 + 0.21) + 0.45))
        UIColor.whiteColor().setFill()
        ovalPath.fill()

        //// Up_Location_Pin
        //// Group 4
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.37985 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.00000 * logooutlinesvgGroup.height))
        bezierPath.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.00000 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.68496 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.37985 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.00000 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.00000 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.51097 * logooutlinesvgGroup.height))
        bezierPath.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.37985 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 1.00000 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.00000 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.85895 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.17007 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 1.00000 * logooutlinesvgGroup.height))
        bezierPath.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.75971 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.68496 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.58964 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 1.00000 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.75971 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.85895 * logooutlinesvgGroup.height))
        bezierPath.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.37985 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.00000 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.75971 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.51097 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.37985 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.00000 * logooutlinesvgGroup.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.37986 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.95880 * logooutlinesvgGroup.height))
        bezierPath.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.04062 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.67745 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.19250 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.95880 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.04062 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.83283 * logooutlinesvgGroup.height))
        bezierPath.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.37986 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.39609 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.04062 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.52206 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.19250 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.39609 * logooutlinesvgGroup.height))
        bezierPath.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.71909 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.67745 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.56721 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.39609 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.71909 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.52206 * logooutlinesvgGroup.height))
        bezierPath.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.37986 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.95880 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.71909 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.83283 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.56721 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.95880 * logooutlinesvgGroup.height))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        UIColor.whiteColor().setFill()
        bezierPath.fill()
        

        //// Degree_Location_Pin
        //// Group 6
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(logooutlinesvgGroup.minX + 1.00000 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.33374 * logooutlinesvgGroup.height))
        bezier2Path.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.18782 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.43885 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 1.00000 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.33374 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.34589 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.35180 * logooutlinesvgGroup.height))
        bezier2Path.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.09149 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.83405 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.02975 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.52590 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + -0.01338 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.70284 * logooutlinesvgGroup.height))
        bezier2Path.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.56758 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.91402 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.19635 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.96527 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.40951 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 1.00107 * logooutlinesvgGroup.height))
        bezier2Path.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 1.00000 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.33374 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.72566 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.82697 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 1.00000 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.33374 * logooutlinesvgGroup.height))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.12892 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.81344 * logooutlinesvgGroup.height))
        bezier2Path.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.21496 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.46050 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.03527 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.69626 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.07379 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.53824 * logooutlinesvgGroup.height))
        bezier2Path.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.64015 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.53191 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.35613 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.38275 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.54649 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.41473 * logooutlinesvgGroup.height))
        bezier2Path.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.55411 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.88486 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.73380 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.64910 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.69528 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.80712 * logooutlinesvgGroup.height))
        bezier2Path.addCurveToPoint(CGPointMake(logooutlinesvgGroup.minX + 0.12892 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.81344 * logooutlinesvgGroup.height), controlPoint1: CGPointMake(logooutlinesvgGroup.minX + 0.41294 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.96260 * logooutlinesvgGroup.height), controlPoint2: CGPointMake(logooutlinesvgGroup.minX + 0.22258 * logooutlinesvgGroup.width, logooutlinesvgGroup.minY + 0.93062 * logooutlinesvgGroup.height))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        UIColor.whiteColor().setFill()
        bezier2Path.fill()
    }



}
