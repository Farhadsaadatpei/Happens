//
//  PointIndicatorOutSide.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/25/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class PointIndicatorOutSide: UIView {


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //// Color Declarations
        let cloud = UIColor(red: 0.897, green: 0.902, blue: 0.903, alpha: 1.000)
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(5, 5, 49.5, 49.5))
        cloud.setStroke()
        ovalPath.lineWidth = 4
        ovalPath.stroke()

    }
    

}
