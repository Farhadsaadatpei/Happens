//
//  RetakePhotoButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/23/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class RetakePhotoButton: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //// Color Declarations
        let cloud = UIColor(red: 0.897, green: 0.902, blue: 0.903, alpha: 1.000)
        let color18 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        cloud.setStroke()
        bezierPath.lineWidth = 2.5
        bezierPath.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(20, 19))
        bezier4Path.addLineToPoint(CGPointMake(60.15, 60))
        bezier4Path.moveToPoint(CGPointMake(20, 59.15))
        bezier4Path.addLineToPoint(CGPointMake(61, 19))
        color18.setStroke()
        bezier4Path.lineWidth = 2.5
        bezier4Path.stroke()
    }


}
