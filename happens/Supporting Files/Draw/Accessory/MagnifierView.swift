//
//  Magnifier.swift
//  happens
//
//  Created by Vilvas, Inc. on 11/10/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class MagnifierView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawMagnifier(frame: self.bounds)
    }
    
    
    var color: UIColor!

    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    func drawMagnifier(frame frame: CGRect = CGRectMake(0, 0, 200, 200)) {
        
        //// magnify Drawing
        let magnifyPath = UIBezierPath()
        magnifyPath.moveToPoint(CGPointMake(frame.minX + 0.58358 * frame.width, frame.minY + 0.62144 * frame.height))
        magnifyPath.addCurveToPoint(CGPointMake(frame.minX + 0.44958 * frame.width, frame.minY + 0.66338 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.54559 * frame.width, frame.minY + 0.64788 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.49940 * frame.width, frame.minY + 0.66338 * frame.height))
        magnifyPath.addCurveToPoint(CGPointMake(frame.minX + 0.21500 * frame.width, frame.minY + 0.42919 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.32003 * frame.width, frame.minY + 0.66338 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.21500 * frame.width, frame.minY + 0.55853 * frame.height))
        magnifyPath.addCurveToPoint(CGPointMake(frame.minX + 0.44958 * frame.width, frame.minY + 0.19500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.21500 * frame.width, frame.minY + 0.29985 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.32003 * frame.width, frame.minY + 0.19500 * frame.height))
        magnifyPath.addCurveToPoint(CGPointMake(frame.minX + 0.68417 * frame.width, frame.minY + 0.42919 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.57914 * frame.width, frame.minY + 0.19500 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.68417 * frame.width, frame.minY + 0.29985 * frame.height))
        magnifyPath.addCurveToPoint(CGPointMake(frame.minX + 0.62492 * frame.width, frame.minY + 0.58478 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.68417 * frame.width, frame.minY + 0.48891 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.66178 * frame.width, frame.minY + 0.54341 * frame.height))
        magnifyPath.addLineToPoint(CGPointMake(frame.minX + 0.80000 * frame.width, frame.minY + 0.75956 * frame.height))
        magnifyPath.addCurveToPoint(CGPointMake(frame.minX + 0.80010 * frame.width, frame.minY + 0.76527 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.80152 * frame.width, frame.minY + 0.76109 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.80165 * frame.width, frame.minY + 0.76373 * frame.height))
        magnifyPath.addLineToPoint(CGPointMake(frame.minX + 0.76669 * frame.width, frame.minY + 0.79863 * frame.height))
        magnifyPath.addCurveToPoint(CGPointMake(frame.minX + 0.76097 * frame.width, frame.minY + 0.79853 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.76518 * frame.width, frame.minY + 0.80014 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.76257 * frame.width, frame.minY + 0.80013 * frame.height))
        magnifyPath.addLineToPoint(CGPointMake(frame.minX + 0.58358 * frame.width, frame.minY + 0.62144 * frame.height))
        magnifyPath.addLineToPoint(CGPointMake(frame.minX + 0.58358 * frame.width, frame.minY + 0.62144 * frame.height))
        magnifyPath.closePath()
        magnifyPath.moveToPoint(CGPointMake(frame.minX + 0.44958 * frame.width, frame.minY + 0.63583 * frame.height))
        magnifyPath.addCurveToPoint(CGPointMake(frame.minX + 0.65657 * frame.width, frame.minY + 0.42919 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.56390 * frame.width, frame.minY + 0.63583 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65657 * frame.width, frame.minY + 0.54331 * frame.height))
        magnifyPath.addCurveToPoint(CGPointMake(frame.minX + 0.44958 * frame.width, frame.minY + 0.22255 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65657 * frame.width, frame.minY + 0.31507 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.56390 * frame.width, frame.minY + 0.22255 * frame.height))
        magnifyPath.addCurveToPoint(CGPointMake(frame.minX + 0.24260 * frame.width, frame.minY + 0.42919 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.33527 * frame.width, frame.minY + 0.22255 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.24260 * frame.width, frame.minY + 0.31507 * frame.height))
        magnifyPath.addCurveToPoint(CGPointMake(frame.minX + 0.44958 * frame.width, frame.minY + 0.63583 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.24260 * frame.width, frame.minY + 0.54331 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.33527 * frame.width, frame.minY + 0.63583 * frame.height))
        magnifyPath.addLineToPoint(CGPointMake(frame.minX + 0.44958 * frame.width, frame.minY + 0.63583 * frame.height))
        magnifyPath.closePath()
        magnifyPath.miterLimit = 4;
        
        magnifyPath.usesEvenOddFillRule = true;
        
        color.setFill()
        magnifyPath.fill()
    }


}
