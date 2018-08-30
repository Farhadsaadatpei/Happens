//
//  ComposeButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/16/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class ComposeButton: UIButton {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawCompose(frame: self.bounds)
    }
    
    var color: UIColor!
    
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }
    
    func drawCompose(frame frame: CGRect) {
        let fillColor6 = color

        let group2: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.02667 + 0.5), floor(frame.width * 0.98673 + 0.5) - floor(frame.width * 0.00000 + 0.5) + 0, floor(frame.height * 0.98667 + 0.5) - floor(frame.height * 0.02667 + 0.5))
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(group2.minX + 0.34782 * group2.width, group2.minY + 0.59006 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.34782 * group2.width, group2.minY + 0.68182 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.43532 * group2.width, group2.minY + 0.68182 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.92472 * group2.width, group2.minY + 0.17045 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.83667 * group2.width, group2.minY + 0.07869 * group2.height))
        bezierPath.addLineToPoint(CGPointMake(group2.minX + 0.34782 * group2.width, group2.minY + 0.59006 * group2.height))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        fillColor6.setFill()
        bezierPath.fill()
        
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(group2.minX + 0.98966 * group2.width, group2.minY + 0.04631 * group2.height))
        bezier2Path.addLineToPoint(CGPointMake(group2.minX + 0.95569 * group2.width, group2.minY + 0.01080 * group2.height))
        bezier2Path.addCurveToPoint(CGPointMake(group2.minX + 0.92852 * group2.width, group2.minY + 0.00000 * group2.height), controlPoint1: CGPointMake(group2.minX + 0.94836 * group2.width, group2.minY + 0.00398 * group2.height), controlPoint2: CGPointMake(group2.minX + 0.93885 * group2.width, group2.minY + 0.00000 * group2.height))
        bezier2Path.addCurveToPoint(CGPointMake(group2.minX + 0.90162 * group2.width, group2.minY + 0.01080 * group2.height), controlPoint1: CGPointMake(group2.minX + 0.91819 * group2.width, group2.minY + 0.00000 * group2.height), controlPoint2: CGPointMake(group2.minX + 0.90868 * group2.width, group2.minY + 0.00426 * group2.height))
        bezier2Path.addLineToPoint(CGPointMake(group2.minX + 0.86874 * group2.width, group2.minY + 0.04545 * group2.height))
        bezier2Path.addLineToPoint(CGPointMake(group2.minX + 0.86901 * group2.width, group2.minY + 0.04574 * group2.height))
        bezier2Path.addLineToPoint(CGPointMake(group2.minX + 0.89945 * group2.width, group2.minY + 0.07784 * group2.height))
        bezier2Path.addLineToPoint(CGPointMake(group2.minX + 0.95651 * group2.width, group2.minY + 0.13750 * group2.height))
        bezier2Path.addLineToPoint(CGPointMake(group2.minX + 0.98966 * group2.width, group2.minY + 0.10284 * group2.height))
        bezier2Path.addCurveToPoint(CGPointMake(group2.minX + 0.99999 * group2.width, group2.minY + 0.07472 * group2.height), controlPoint1: CGPointMake(group2.minX + 0.99618 * group2.width, group2.minY + 0.09545 * group2.height), controlPoint2: CGPointMake(group2.minX + 0.99999 * group2.width, group2.minY + 0.08551 * group2.height))
        bezier2Path.addCurveToPoint(CGPointMake(group2.minX + 0.98966 * group2.width, group2.minY + 0.04631 * group2.height), controlPoint1: CGPointMake(group2.minX + 1.00026 * group2.width, group2.minY + 0.06392 * group2.height), controlPoint2: CGPointMake(group2.minX + 0.99618 * group2.width, group2.minY + 0.05398 * group2.height))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        fillColor6.setFill()
        bezier2Path.fill()

        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(group2.minX + 0.47690 * group2.width, group2.minY + 0.72727 * group2.height))
        bezier3Path.addLineToPoint(CGPointMake(group2.minX + 0.30434 * group2.width, group2.minY + 0.72727 * group2.height))
        bezier3Path.addLineToPoint(CGPointMake(group2.minX + 0.30434 * group2.width, group2.minY + 0.54659 * group2.height))
        bezier3Path.addLineToPoint(CGPointMake(group2.minX + 0.65217 * group2.width, group2.minY + 0.18295 * group2.height))
        bezier3Path.addLineToPoint(CGPointMake(group2.minX + 0.65135 * group2.width, group2.minY + 0.18295 * group2.height))
        bezier3Path.addLineToPoint(CGPointMake(group2.minX + 0.65244 * group2.width, group2.minY + 0.18182 * group2.height))
        bezier3Path.addLineToPoint(CGPointMake(group2.minX + 0.00000 * group2.width, group2.minY + 0.18182 * group2.height))
        bezier3Path.addLineToPoint(CGPointMake(group2.minX + 0.00000 * group2.width, group2.minY + 1.00000 * group2.height))
        bezier3Path.addLineToPoint(CGPointMake(group2.minX + 0.82608 * group2.width, group2.minY + 1.00000 * group2.height))
        bezier3Path.addLineToPoint(CGPointMake(group2.minX + 0.82608 * group2.width, group2.minY + 0.36875 * group2.height))
        bezier3Path.addLineToPoint(CGPointMake(group2.minX + 0.82635 * group2.width, group2.minY + 0.36165 * group2.height))
        bezier3Path.addLineToPoint(CGPointMake(group2.minX + 0.47690 * group2.width, group2.minY + 0.72727 * group2.height))
        bezier3Path.closePath()
        bezier3Path.miterLimit = 4;
        
        fillColor6.setFill()
        bezier3Path.fill()
    }


}
