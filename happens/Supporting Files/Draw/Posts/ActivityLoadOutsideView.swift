//
//  ActivityLoadOutsideView.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/15/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class ActivityLoadOutsideView: UIView {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
      self.drawActivityLoadingOutside(frame: self.bounds)
    }
    
    
    var color: UIColor!
    
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }
    
    func drawActivityLoadingOutside(frame frame: CGRect = CGRectMake(0, 0, 200, 200)) {
        
        //// Activity Outside Ring Drawing
        let activityOutsideRingPath = UIBezierPath()
        activityOutsideRingPath.moveToPoint(CGPointMake(frame.minX + 0.72500 * frame.width, frame.minY + 0.50000 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.57287 * frame.width, frame.minY + 0.28706 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.72500 * frame.width, frame.minY + 0.40306 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.66313 * frame.width, frame.minY + 0.31793 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.55731 * frame.width, frame.minY + 0.25531 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.55981 * frame.width, frame.minY + 0.28259 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.55284 * frame.width, frame.minY + 0.26837 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.58906 * frame.width, frame.minY + 0.23975 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.56178 * frame.width, frame.minY + 0.24225 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.57599 * frame.width, frame.minY + 0.23528 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.77500 * frame.width, frame.minY + 0.50000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.69939 * frame.width, frame.minY + 0.27749 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77500 * frame.width, frame.minY + 0.38152 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.75000 * frame.width, frame.minY + 0.52500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77500 * frame.width, frame.minY + 0.51381 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.76381 * frame.width, frame.minY + 0.52500 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.72500 * frame.width, frame.minY + 0.50000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.73619 * frame.width, frame.minY + 0.52500 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.72500 * frame.width, frame.minY + 0.51381 * frame.height))
        activityOutsideRingPath.closePath()
        activityOutsideRingPath.moveToPoint(CGPointMake(frame.minX + 0.37074 * frame.width, frame.minY + 0.31581 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.27500 * frame.width, frame.minY + 0.50000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.31116 * frame.width, frame.minY + 0.35771 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.27500 * frame.width, frame.minY + 0.42579 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.28391 * frame.width, frame.minY + 0.56291 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.27500 * frame.width, frame.minY + 0.52154 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.27802 * frame.width, frame.minY + 0.54266 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.26688 * frame.width, frame.minY + 0.59389 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.28776 * frame.width, frame.minY + 0.57617 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.28013 * frame.width, frame.minY + 0.59004 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.23589 * frame.width, frame.minY + 0.57686 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.25362 * frame.width, frame.minY + 0.59775 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.23975 * frame.width, frame.minY + 0.59012 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.22500 * frame.width, frame.minY + 0.50000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.22869 * frame.width, frame.minY + 0.55209 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.22500 * frame.width, frame.minY + 0.52628 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.34198 * frame.width, frame.minY + 0.27491 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.22500 * frame.width, frame.minY + 0.40934 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.26922 * frame.width, frame.minY + 0.32607 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.37681 * frame.width, frame.minY + 0.28098 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.35328 * frame.width, frame.minY + 0.26697 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.36887 * frame.width, frame.minY + 0.26968 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.37074 * frame.width, frame.minY + 0.31581 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.38475 * frame.width, frame.minY + 0.29227 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.38204 * frame.width, frame.minY + 0.30787 * frame.height))
        activityOutsideRingPath.closePath()
        activityOutsideRingPath.moveToPoint(CGPointMake(frame.minX + 0.42352 * frame.width, frame.minY + 0.71167 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.49980 * frame.width, frame.minY + 0.72500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.44775 * frame.width, frame.minY + 0.72043 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.47345 * frame.width, frame.minY + 0.72498 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.67574 * frame.width, frame.minY + 0.64051 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.56922 * frame.width, frame.minY + 0.72500 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.63326 * frame.width, frame.minY + 0.69357 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.71088 * frame.width, frame.minY + 0.63662 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.68437 * frame.width, frame.minY + 0.62974 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.70010 * frame.width, frame.minY + 0.62799 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.71477 * frame.width, frame.minY + 0.67176 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.72166 * frame.width, frame.minY + 0.64525 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.72340 * frame.width, frame.minY + 0.66099 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.49978 * frame.width, frame.minY + 0.77500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66289 * frame.width, frame.minY + 0.73656 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.58456 * frame.width, frame.minY + 0.77500 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.40652 * frame.width, frame.minY + 0.75870 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.46760 * frame.width, frame.minY + 0.77497 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.43617 * frame.width, frame.minY + 0.76941 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.39151 * frame.width, frame.minY + 0.72669 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.39354 * frame.width, frame.minY + 0.75400 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.38681 * frame.width, frame.minY + 0.73967 * frame.height))
        activityOutsideRingPath.addCurveToPoint(CGPointMake(frame.minX + 0.42352 * frame.width, frame.minY + 0.71167 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.39620 * frame.width, frame.minY + 0.71370 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.41053 * frame.width, frame.minY + 0.70698 * frame.height))
        activityOutsideRingPath.closePath()
        color.setFill()
        activityOutsideRingPath.fill()
    }


}
