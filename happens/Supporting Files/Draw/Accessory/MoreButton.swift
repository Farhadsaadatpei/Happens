//
//  MoreButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 11/11/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class MoreButton: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawMore(frame: self.bounds)
    }

    
    var color: UIColor!
    
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }
    
    func drawMore(frame frame: CGRect = CGRectMake(0, 0, 200, 200)) {
        
        //// editor-more-detail-glyph Drawing
        let editormoredetailglyphPath = UIBezierPath()
        editormoredetailglyphPath.moveToPoint(CGPointMake(frame.minX + 0.24170 * frame.width, frame.minY + 0.57500 * frame.height))
        editormoredetailglyphPath.addCurveToPoint(CGPointMake(frame.minX + 0.31841 * frame.width, frame.minY + 0.49750 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.28407 * frame.width, frame.minY + 0.57500 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.31841 * frame.width, frame.minY + 0.54030 * frame.height))
        editormoredetailglyphPath.addCurveToPoint(CGPointMake(frame.minX + 0.24170 * frame.width, frame.minY + 0.42000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.31841 * frame.width, frame.minY + 0.45470 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.28407 * frame.width, frame.minY + 0.42000 * frame.height))
        editormoredetailglyphPath.addCurveToPoint(CGPointMake(frame.minX + 0.16500 * frame.width, frame.minY + 0.49750 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.19934 * frame.width, frame.minY + 0.42000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.16500 * frame.width, frame.minY + 0.45470 * frame.height))
        editormoredetailglyphPath.addCurveToPoint(CGPointMake(frame.minX + 0.24170 * frame.width, frame.minY + 0.57500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.16500 * frame.width, frame.minY + 0.54030 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.19934 * frame.width, frame.minY + 0.57500 * frame.height))
        editormoredetailglyphPath.addLineToPoint(CGPointMake(frame.minX + 0.24170 * frame.width, frame.minY + 0.57500 * frame.height))
        editormoredetailglyphPath.closePath()
        editormoredetailglyphPath.moveToPoint(CGPointMake(frame.minX + 0.50250 * frame.width, frame.minY + 0.57500 * frame.height))
        editormoredetailglyphPath.addCurveToPoint(CGPointMake(frame.minX + 0.57920 * frame.width, frame.minY + 0.49750 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.54486 * frame.width, frame.minY + 0.57500 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.57920 * frame.width, frame.minY + 0.54030 * frame.height))
        editormoredetailglyphPath.addCurveToPoint(CGPointMake(frame.minX + 0.50250 * frame.width, frame.minY + 0.42000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.57920 * frame.width, frame.minY + 0.45470 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.54486 * frame.width, frame.minY + 0.42000 * frame.height))
        editormoredetailglyphPath.addCurveToPoint(CGPointMake(frame.minX + 0.42580 * frame.width, frame.minY + 0.49750 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.46014 * frame.width, frame.minY + 0.42000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.42580 * frame.width, frame.minY + 0.45470 * frame.height))
        editormoredetailglyphPath.addCurveToPoint(CGPointMake(frame.minX + 0.50250 * frame.width, frame.minY + 0.57500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.42580 * frame.width, frame.minY + 0.54030 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.46014 * frame.width, frame.minY + 0.57500 * frame.height))
        editormoredetailglyphPath.addLineToPoint(CGPointMake(frame.minX + 0.50250 * frame.width, frame.minY + 0.57500 * frame.height))
        editormoredetailglyphPath.closePath()
        editormoredetailglyphPath.moveToPoint(CGPointMake(frame.minX + 0.76330 * frame.width, frame.minY + 0.57500 * frame.height))
        editormoredetailglyphPath.addCurveToPoint(CGPointMake(frame.minX + 0.84000 * frame.width, frame.minY + 0.49750 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.80566 * frame.width, frame.minY + 0.57500 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.84000 * frame.width, frame.minY + 0.54030 * frame.height))
        editormoredetailglyphPath.addCurveToPoint(CGPointMake(frame.minX + 0.76330 * frame.width, frame.minY + 0.42000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.84000 * frame.width, frame.minY + 0.45470 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.80566 * frame.width, frame.minY + 0.42000 * frame.height))
        editormoredetailglyphPath.addCurveToPoint(CGPointMake(frame.minX + 0.68659 * frame.width, frame.minY + 0.49750 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.72093 * frame.width, frame.minY + 0.42000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.68659 * frame.width, frame.minY + 0.45470 * frame.height))
        editormoredetailglyphPath.addCurveToPoint(CGPointMake(frame.minX + 0.76330 * frame.width, frame.minY + 0.57500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.68659 * frame.width, frame.minY + 0.54030 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.72093 * frame.width, frame.minY + 0.57500 * frame.height))
        editormoredetailglyphPath.addLineToPoint(CGPointMake(frame.minX + 0.76330 * frame.width, frame.minY + 0.57500 * frame.height))
        editormoredetailglyphPath.closePath()
        editormoredetailglyphPath.miterLimit = 4;
        
        editormoredetailglyphPath.usesEvenOddFillRule = true;
        
        color.setFill()
        editormoredetailglyphPath.fill()
    }


}
