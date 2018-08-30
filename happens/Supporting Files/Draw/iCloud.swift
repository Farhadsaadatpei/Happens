//
//  iCloud.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/5/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class iCloud: UIButton {

   
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawCloudIcon(frame: self.bounds)
    }
    
    
    func drawCloudIcon(frame frame: CGRect) {
        //// Color Declarations
        let primary = UIColor(red: 0.173, green: 0.243, blue: 0.314, alpha: 1.000)
        
        //// Bezier 102 Drawing
        let bezier102Path = UIBezierPath()
        bezier102Path.moveToPoint(CGPointMake(frame.minX + 0.86357 * frame.width, frame.minY + 0.42413 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.57234 * frame.width, frame.minY + 0.16667 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.84632 * frame.width, frame.minY + 0.27818 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.72219 * frame.width, frame.minY + 0.16667 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.33185 * frame.width, frame.minY + 0.29167 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.47618 * frame.width, frame.minY + 0.16667 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.38639 * frame.width, frame.minY + 0.21394 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.27700 * frame.width, frame.minY + 0.28173 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.31442 * frame.width, frame.minY + 0.28511 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.29584 * frame.width, frame.minY + 0.28173 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.12317 * frame.width, frame.minY + 0.41352 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.19850 * frame.width, frame.minY + 0.28173 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.13428 * frame.width, frame.minY + 0.33824 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.61112 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.04776 * frame.width, frame.minY + 0.45050 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.52618 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.22132 * frame.width, frame.minY + 0.83156 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.73268 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.09928 * frame.width, frame.minY + 0.83156 * frame.height))
        bezier102Path.addLineToPoint(CGPointMake(frame.minX + 0.78865 * frame.width, frame.minY + 0.83156 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.62103 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.90520 * frame.width, frame.minY + 0.83156 * frame.height), controlPoint2: CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.73711 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.86357 * frame.width, frame.minY + 0.42413 * frame.height), controlPoint1: CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.53296 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.94486 * frame.width, frame.minY + 0.45479 * frame.height))
        bezier102Path.closePath()
        bezier102Path.moveToPoint(CGPointMake(frame.minX + 0.78865 * frame.width, frame.minY + 0.77242 * frame.height))
        bezier102Path.addLineToPoint(CGPointMake(frame.minX + 0.22132 * frame.width, frame.minY + 0.77242 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.05939 * frame.width, frame.minY + 0.61112 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.13204 * frame.width, frame.minY + 0.77242 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.05939 * frame.width, frame.minY + 0.70006 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.16207 * frame.width, frame.minY + 0.46101 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.05939 * frame.width, frame.minY + 0.54437 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.09970 * frame.width, frame.minY + 0.48547 * frame.height))
        bezier102Path.addLineToPoint(CGPointMake(frame.minX + 0.18039 * frame.width, frame.minY + 0.45384 * frame.height))
        bezier102Path.addLineToPoint(CGPointMake(frame.minX + 0.18088 * frame.width, frame.minY + 0.43422 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.27700 * frame.width, frame.minY + 0.34089 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.18220 * frame.width, frame.minY + 0.38189 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.22443 * frame.width, frame.minY + 0.34089 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.32722 * frame.width, frame.minY + 0.35499 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.29478 * frame.width, frame.minY + 0.34089 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.31215 * frame.width, frame.minY + 0.34577 * frame.height))
        bezier102Path.addLineToPoint(CGPointMake(frame.minX + 0.35346 * frame.width, frame.minY + 0.37106 * frame.height))
        bezier102Path.addLineToPoint(CGPointMake(frame.minX + 0.36861 * frame.width, frame.minY + 0.34436 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.57234 * frame.width, frame.minY + 0.22581 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.41014 * frame.width, frame.minY + 0.27124 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.48819 * frame.width, frame.minY + 0.22581 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.80595 * frame.width, frame.minY + 0.44760 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.69743 * frame.width, frame.minY + 0.22581 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.80004 * frame.width, frame.minY + 0.32323 * frame.height))
        bezier102Path.addLineToPoint(CGPointMake(frame.minX + 0.80698 * frame.width, frame.minY + 0.46920 * frame.height))
        bezier102Path.addLineToPoint(CGPointMake(frame.minX + 0.82796 * frame.width, frame.minY + 0.47477 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.94063 * frame.width, frame.minY + 0.62103 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.89430 * frame.width, frame.minY + 0.49242 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.94063 * frame.width, frame.minY + 0.55255 * frame.height))
        bezier102Path.addCurveToPoint(CGPointMake(frame.minX + 0.78865 * frame.width, frame.minY + 0.77242 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.94063 * frame.width, frame.minY + 0.70451 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.87245 * frame.width, frame.minY + 0.77242 * frame.height))
        bezier102Path.closePath()
        bezier102Path.miterLimit = 4;
        
        primary.setFill()
        bezier102Path.fill()
    }


}
