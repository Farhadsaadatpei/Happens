//
//  NinjaView.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/13/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class NinjaView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawNinja(frame: self.bounds)
    }
    
    
    var color: UIColor!
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }
    
    func drawNinja(frame frame: CGRect = CGRectMake(0, 0, 200, 200)) {
        //// Color Declarations
        let primary = color
        
        
        //// Subframes
        let layer1: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.10060 + 0.38) + 0.12, frame.minY + floor(frame.height * 0.09695 - 0.39) + 0.89, floor(frame.width * 0.90346 - 0.19) - floor(frame.width * 0.10060 + 0.38) + 0.57, floor(frame.height * 0.90554 - 0.11) - floor(frame.height * 0.09695 - 0.39) - 0.28)
        
        
        //// layer1
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(layer1.minX + 0.65771 * layer1.width, layer1.minY + 0.30776 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.65771 * layer1.width, layer1.minY + 0.37466 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.67315 * layer1.width, layer1.minY + 0.32623 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.67315 * layer1.width, layer1.minY + 0.35618 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.60181 * layer1.width, layer1.minY + 0.37466 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.64228 * layer1.width, layer1.minY + 0.39313 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.61725 * layer1.width, layer1.minY + 0.39313 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.60181 * layer1.width, layer1.minY + 0.30776 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.58638 * layer1.width, layer1.minY + 0.35618 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.58638 * layer1.width, layer1.minY + 0.32623 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.65771 * layer1.width, layer1.minY + 0.30776 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.61725 * layer1.width, layer1.minY + 0.28928 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.64228 * layer1.width, layer1.minY + 0.28928 * layer1.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(layer1.minX + 0.46478 * layer1.width, layer1.minY + 0.30776 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.46478 * layer1.width, layer1.minY + 0.37466 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.47997 * layer1.width, layer1.minY + 0.32623 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.47997 * layer1.width, layer1.minY + 0.35618 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.40979 * layer1.width, layer1.minY + 0.37466 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.44960 * layer1.width, layer1.minY + 0.39313 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.42498 * layer1.width, layer1.minY + 0.39313 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.40979 * layer1.width, layer1.minY + 0.30776 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.39460 * layer1.width, layer1.minY + 0.35618 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.39460 * layer1.width, layer1.minY + 0.32623 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.46478 * layer1.width, layer1.minY + 0.30776 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.42498 * layer1.width, layer1.minY + 0.28928 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.44960 * layer1.width, layer1.minY + 0.28928 * layer1.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(layer1.minX + 0.70186 * layer1.width, layer1.minY + 0.21287 * layer1.height))
        bezierPath.addLineToPoint(CGPointMake(layer1.minX + 0.38010 * layer1.width, layer1.minY + 0.21287 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.28558 * layer1.width, layer1.minY + 0.30611 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.32774 * layer1.width, layer1.minY + 0.21287 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.28558 * layer1.width, layer1.minY + 0.25445 * layer1.height))
        bezierPath.addLineToPoint(CGPointMake(layer1.minX + 0.28558 * layer1.width, layer1.minY + 0.36859 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.38010 * layer1.width, layer1.minY + 0.46183 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.28558 * layer1.width, layer1.minY + 0.42024 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.32774 * layer1.width, layer1.minY + 0.46183 * layer1.height))
        bezierPath.addLineToPoint(CGPointMake(layer1.minX + 0.70186 * layer1.width, layer1.minY + 0.46183 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.79638 * layer1.width, layer1.minY + 0.36859 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.75422 * layer1.width, layer1.minY + 0.46183 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.79638 * layer1.width, layer1.minY + 0.42024 * layer1.height))
        bezierPath.addLineToPoint(CGPointMake(layer1.minX + 0.79638 * layer1.width, layer1.minY + 0.30611 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.70186 * layer1.width, layer1.minY + 0.21287 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.79638 * layer1.width, layer1.minY + 0.25445 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.75422 * layer1.width, layer1.minY + 0.21287 * layer1.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(layer1.minX + 0.89575 * layer1.width, layer1.minY + 0.33184 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.69943 * layer1.width, layer1.minY + 0.63054 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.89575 * layer1.width, layer1.minY + 0.46322 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.81564 * layer1.width, layer1.minY + 0.57677 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.93686 * layer1.width, layer1.minY + 0.80994 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.79487 * layer1.width, layer1.minY + 0.66126 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.87717 * layer1.width, layer1.minY + 0.72271 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.99319 * layer1.width, layer1.minY + 0.93714 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.96085 * layer1.width, layer1.minY + 0.84500 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.99284 * layer1.width, layer1.minY + 0.91724 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.98335 * layer1.width, layer1.minY + 0.96974 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.99333 * layer1.width, layer1.minY + 0.94542 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 1.01368 * layer1.width, layer1.minY + 0.95475 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.10711 * layer1.width, layer1.minY + 0.97948 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.88489 * layer1.width, layer1.minY + 1.01842 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.13173 * layer1.width, layer1.minY + 0.99810 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.10824 * layer1.width, layer1.minY + 0.93686 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.09375 * layer1.width, layer1.minY + 0.96937 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.09909 * layer1.width, layer1.minY + 0.97125 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.21698 * layer1.width, layer1.minY + 0.74814 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.12695 * layer1.width, layer1.minY + 0.86658 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.16507 * layer1.width, layer1.minY + 0.80146 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.00739 * layer1.width, layer1.minY + 0.57344 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.10306 * layer1.width, layer1.minY + 0.65318 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.00739 * layer1.width, layer1.minY + 0.57344 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.00142 * layer1.width, layer1.minY + 0.56764 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.00412 * layer1.width, layer1.minY + 0.57071 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.00249 * layer1.width, layer1.minY + 0.56935 * layer1.height))
        bezierPath.addLineToPoint(CGPointMake(layer1.minX + 0.00120 * layer1.width, layer1.minY + 0.56733 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.00056 * layer1.width, layer1.minY + 0.55980 * layer1.height), controlPoint1: CGPointMake(layer1.minX + -0.00013 * layer1.width, layer1.minY + 0.56504 * layer1.height), controlPoint2: CGPointMake(layer1.minX + -0.00037 * layer1.width, layer1.minY + 0.56228 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.00563 * layer1.width, layer1.minY + 0.55276 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.00149 * layer1.width, layer1.minY + 0.55760 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.00287 * layer1.width, layer1.minY + 0.55599 * layer1.height))
        bezierPath.addLineToPoint(CGPointMake(layer1.minX + 0.03572 * layer1.width, layer1.minY + 0.51764 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.04160 * layer1.width, layer1.minY + 0.51175 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.03849 * layer1.width, layer1.minY + 0.51442 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.03987 * layer1.width, layer1.minY + 0.51280 * layer1.height))
        bezierPath.addLineToPoint(CGPointMake(layer1.minX + 0.04191 * layer1.width, layer1.minY + 0.51153 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.04954 * layer1.width, layer1.minY + 0.51090 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.04424 * layer1.width, layer1.minY + 0.51022 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.04703 * layer1.width, layer1.minY + 0.50999 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.05668 * layer1.width, layer1.minY + 0.51591 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.05178 * layer1.width, layer1.minY + 0.51182 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.05341 * layer1.width, layer1.minY + 0.51318 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.27489 * layer1.width, layer1.minY + 0.69780 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.05668 * layer1.width, layer1.minY + 0.51591 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.15722 * layer1.width, layer1.minY + 0.59972 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.34798 * layer1.width, layer1.minY + 0.65401 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.29768 * layer1.width, layer1.minY + 0.68110 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.32214 * layer1.width, layer1.minY + 0.66639 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.39922 * layer1.width, layer1.minY + 0.63217 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.36609 * layer1.width, layer1.minY + 0.64533 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.38289 * layer1.width, layer1.minY + 0.63811 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.19930 * layer1.width, layer1.minY + 0.33184 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.28107 * layer1.width, layer1.minY + 0.57910 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.19930 * layer1.width, layer1.minY + 0.46457 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.54752 * layer1.width, layer1.minY + 0.00000 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.19930 * layer1.width, layer1.minY + 0.14857 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.35521 * layer1.width, layer1.minY + 0.00000 * layer1.height))
        bezierPath.addCurveToPoint(CGPointMake(layer1.minX + 0.89575 * layer1.width, layer1.minY + 0.33184 * layer1.height), controlPoint1: CGPointMake(layer1.minX + 0.73984 * layer1.width, layer1.minY + -0.00000 * layer1.height), controlPoint2: CGPointMake(layer1.minX + 0.89575 * layer1.width, layer1.minY + 0.14857 * layer1.height))
        bezierPath.closePath()
        primary.setFill()
        bezierPath.fill()
    }



}
