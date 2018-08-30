//
//  ActivityLoadInsideView.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/15/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class ActivityLoadInsideView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawActivityLoadingInside(frame: self.bounds)
    }
    
    
    var color: UIColor!
    
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }

    func drawActivityLoadingInside(frame frame: CGRect = CGRectMake(0, 0, 200, 200)) {
        
        //// Activity Outside Ring 2 Drawing
        let activityOutsideRing2Path = UIBezierPath()
        activityOutsideRing2Path.moveToPoint(CGPointMake(frame.minX + 0.55851 * frame.width, frame.minY + 0.35106 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.40613 * frame.width, frame.minY + 0.37665 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.50603 * frame.width, frame.minY + 0.33339 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.44919 * frame.width, frame.minY + 0.34345 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.37107 * frame.width, frame.minY + 0.37211 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.39519 * frame.width, frame.minY + 0.38508 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.37949 * frame.width, frame.minY + 0.38305 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.37560 * frame.width, frame.minY + 0.33705 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.36264 * frame.width, frame.minY + 0.36118 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.36467 * frame.width, frame.minY + 0.34548 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.57447 * frame.width, frame.minY + 0.30368 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.43176 * frame.width, frame.minY + 0.29376 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.50599 * frame.width, frame.minY + 0.28062 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.59019 * frame.width, frame.minY + 0.33535 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.58756 * frame.width, frame.minY + 0.30809 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.59459 * frame.width, frame.minY + 0.32227 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.55851 * frame.width, frame.minY + 0.35106 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.58578 * frame.width, frame.minY + 0.34844 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.57160 * frame.width, frame.minY + 0.35547 * frame.height))
        activityOutsideRing2Path.closePath()
        activityOutsideRing2Path.moveToPoint(CGPointMake(frame.minX + 0.34774 * frame.width, frame.minY + 0.54743 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.45399 * frame.width, frame.minY + 0.66144 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.36160 * frame.width, frame.minY + 0.60055 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.40100 * frame.width, frame.minY + 0.64359 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.46472 * frame.width, frame.minY + 0.66465 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.45754 * frame.width, frame.minY + 0.66263 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.46112 * frame.width, frame.minY + 0.66371 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.48253 * frame.width, frame.minY + 0.69520 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.47807 * frame.width, frame.minY + 0.66817 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.48605 * frame.width, frame.minY + 0.68185 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.45198 * frame.width, frame.minY + 0.71300 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.47901 * frame.width, frame.minY + 0.70855 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.46534 * frame.width, frame.minY + 0.71652 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.43803 * frame.width, frame.minY + 0.70882 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.44730 * frame.width, frame.minY + 0.71177 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.44265 * frame.width, frame.minY + 0.71038 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.29936 * frame.width, frame.minY + 0.56006 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.36889 * frame.width, frame.minY + 0.68554 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.31744 * frame.width, frame.minY + 0.62932 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.31724 * frame.width, frame.minY + 0.52955 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.29587 * frame.width, frame.minY + 0.54670 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.30388 * frame.width, frame.minY + 0.53304 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.34774 * frame.width, frame.minY + 0.54743 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.33060 * frame.width, frame.minY + 0.52607 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.34425 * frame.width, frame.minY + 0.53407 * frame.height))
        activityOutsideRing2Path.closePath()
        activityOutsideRing2Path.moveToPoint(CGPointMake(frame.minX + 0.63596 * frame.width, frame.minY + 0.60629 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.66144 * frame.width, frame.minY + 0.55851 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.64695 * frame.width, frame.minY + 0.59203 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65556 * frame.width, frame.minY + 0.57597 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.65701 * frame.width, frame.minY + 0.44233 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.67441 * frame.width, frame.minY + 0.51999 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.67257 * frame.width, frame.minY + 0.47898 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.67026 * frame.width, frame.minY + 0.40955 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65162 * frame.width, frame.minY + 0.42962 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65755 * frame.width, frame.minY + 0.41494 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.70304 * frame.width, frame.minY + 0.42279 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.68296 * frame.width, frame.minY + 0.40415 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.69764 * frame.width, frame.minY + 0.41008 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.70882 * frame.width, frame.minY + 0.57447 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.72333 * frame.width, frame.minY + 0.47060 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.72574 * frame.width, frame.minY + 0.52424 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.67555 * frame.width, frame.minY + 0.63682 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.70117 * frame.width, frame.minY + 0.59720 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.68992 * frame.width, frame.minY + 0.61819 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.64049 * frame.width, frame.minY + 0.64135 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66712 * frame.width, frame.minY + 0.64775 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65142 * frame.width, frame.minY + 0.64978 * frame.height))
        activityOutsideRing2Path.addCurveToPoint(CGPointMake(frame.minX + 0.63596 * frame.width, frame.minY + 0.60629 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.62955 * frame.width, frame.minY + 0.63292 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.62752 * frame.width, frame.minY + 0.61722 * frame.height))
        activityOutsideRing2Path.closePath()
        color.setFill()
        activityOutsideRing2Path.fill()
    }

}
