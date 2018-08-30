//
//  ExitButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/26/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class XButton: UIButton {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawX(frame: self.bounds)
    }
    
    var color: UIColor!
    var stroke: CGFloat!
    
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }
    
    @IBInspectable var strokeSize: CGFloat = 4{
        didSet {
            stroke = strokeSize
        }
    }
    
    func drawX(frame frame: CGRect = CGRectMake(0, 0, 200, 200)) {
        
        
        //// Subframes
        let xGroup: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.25000 + 0.5), frame.minY + floor(frame.height * 0.25000 + 0.5), floor(frame.width * 0.75000 + 0.5) - floor(frame.width * 0.25000 + 0.5), floor(frame.height * 0.75000 + 0.5) - floor(frame.height * 0.25000 + 0.5))
        
        
        //// X Group
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(xGroup.minX + 0.00000 * xGroup.width, xGroup.minY + 0.00000 * xGroup.height))
        bezierPath.addLineToPoint(CGPointMake(xGroup.minX + 1.00000 * xGroup.width, xGroup.minY + 1.00000 * xGroup.height))
        bezierPath.miterLimit = stroke;
        
        UIColor.blackColor().setStroke()
        bezierPath.lineWidth = stroke
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(xGroup.minX + 0.00000 * xGroup.width, xGroup.minY + 1.00000 * xGroup.height))
        bezier2Path.addLineToPoint(CGPointMake(xGroup.minX + 1.00000 * xGroup.width, xGroup.minY + 0.00000 * xGroup.height))
        bezier2Path.miterLimit = stroke;
        
        UIColor.blackColor().setStroke()
        bezier2Path.lineWidth = stroke
        bezier2Path.stroke()
    }



}
