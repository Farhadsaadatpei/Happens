//
//  NotificationView.swift
//  happens
//
//  Created by Vilvas, Inc. on 11/4/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class NotificationButton: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawNotification(frame: self.bounds)
    }
    
    var color: UIColor!
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }

    
    func drawNotification(frame frame: CGRect = CGRectMake(0, 0, 200, 200)) {
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.83162 * frame.width, frame.minY + 0.07500 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.16837 * frame.width, frame.minY + 0.07500 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.20827 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.10297 * frame.width, frame.minY + 0.07500 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.13432 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.54302 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.16837 * frame.width, frame.minY + 0.67770 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.05000 * frame.width, frame.minY + 0.61697 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.10297 * frame.width, frame.minY + 0.67770 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.70759 * frame.width, frame.minY + 0.67770 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.81969 * frame.width, frame.minY + 0.92585 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.81892 * frame.width, frame.minY + 0.67770 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.83163 * frame.width, frame.minY + 0.67770 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.54302 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.89703 * frame.width, frame.minY + 0.67770 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.61697 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.20827 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.83162 * frame.width, frame.minY + 0.07500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.95000 * frame.width, frame.minY + 0.13432 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.89703 * frame.width, frame.minY + 0.07500 * frame.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.19543 * frame.width, frame.minY + 0.21260 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.80457 * frame.width, frame.minY + 0.21260 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.80457 * frame.width, frame.minY + 0.26764 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.19543 * frame.width, frame.minY + 0.26764 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.19543 * frame.width, frame.minY + 0.21260 * frame.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.19543 * frame.width, frame.minY + 0.35571 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.80457 * frame.width, frame.minY + 0.35571 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.80457 * frame.width, frame.minY + 0.41350 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.19543 * frame.width, frame.minY + 0.41350 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.19543 * frame.width, frame.minY + 0.35571 * frame.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.19543 * frame.width, frame.minY + 0.49882 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.80457 * frame.width, frame.minY + 0.49882 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.80457 * frame.width, frame.minY + 0.55110 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.19543 * frame.width, frame.minY + 0.55110 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.19543 * frame.width, frame.minY + 0.49882 * frame.height))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        color.setFill()
        bezierPath.fill()
    }


}
