//
//  StarView.swift
//  happens
//
//  Created by Vilvas, Inc. on 11/4/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class StarView: UIView {


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawStar(frame: self.bounds)
    }

    
    var color: UIColor!
    @IBInspectable var DefaultColor: UIColor = UIColor.whiteColor(){
        didSet {
            color = DefaultColor
        }
    }
    
    func drawStar(frame frame: CGRect = CGRectMake(0, 0, 200, 200)) {
        
        //// Shape Drawing
        let shapePath = UIBezierPath()
        shapePath.moveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.01937 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.62914 * frame.width, frame.minY + 0.32225 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.95710 * frame.width, frame.minY + 0.35148 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.70896 * frame.width, frame.minY + 0.56790 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.78250 * frame.width, frame.minY + 0.88883 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.71971 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.21750 * frame.width, frame.minY + 0.88883 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.29104 * frame.width, frame.minY + 0.56790 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.04290 * frame.width, frame.minY + 0.35148 * frame.height))
        shapePath.addLineToPoint(CGPointMake(frame.minX + 0.37086 * frame.width, frame.minY + 0.32225 * frame.height))
        shapePath.closePath()
        color.setFill()
        shapePath.fill()
    }



}
