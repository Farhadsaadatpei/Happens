//
//  CellReplyButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/26/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class CellReplyButton: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawCellReplyButton(frame: self.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frame = self.bounds
    }
    
    func drawCellReplyButton(frame frame: CGRect = CGRectMake(0, 0, 120, 120)) {
        //// Color Declarations
        let fillColor9 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let color23 = UIColor(red: 0.102, green: 0.737, blue: 0.612, alpha: 1.000)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.00000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5)))
        color23.setFill()
        rectanglePath.fill()
        
        
        //// Shape Drawing
        let shapePath = UIBezierPath()
        shapePath.moveToPoint(CGPointMake(frame.minX + 0.24167 * frame.width, frame.minY + 0.49583 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.43854 * frame.width, frame.minY + 0.33333 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.43854 * frame.width, frame.minY + 0.43083 * frame.height))
        shapePath.addCurveToPoint(CGPointMake(frame.minX + 0.76667 * frame.width, frame.minY + 0.62583 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.58620 * frame.width, frame.minY + 0.43083 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.70104 * frame.width, frame.minY + 0.46333 * frame.height))
        shapePath.addCurveToPoint(CGPointMake(frame.minX + 0.43854 * frame.width, frame.minY + 0.56083 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66823 * frame.width, frame.minY + 0.54458 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.56979 * frame.width, frame.minY + 0.52833 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.43854 * frame.width, frame.minY + 0.65833 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.24167 * frame.width, frame.minY + 0.49583 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.24167 * frame.width, frame.minY + 0.49583 * frame.height))
        shapePath.closePath()
        shapePath.miterLimit = 4;
        
        shapePath.usesEvenOddFillRule = true;
        
        fillColor9.setFill()
        shapePath.fill()
    }



}
