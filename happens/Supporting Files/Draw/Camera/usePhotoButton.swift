//
//  usePhotoButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/23/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class usePhotoButton: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //// Color Declarations
        let color17 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(17, 40))
        bezierPath.addLineToPoint(CGPointMake(35.5, 64.5))
        bezierPath.addLineToPoint(CGPointMake(65, 16))
        bezierPath.lineJoinStyle = CGLineJoin.Round;
        
        color17.setStroke()
        bezierPath.lineWidth = 2.5
        bezierPath.stroke()

    }
}
