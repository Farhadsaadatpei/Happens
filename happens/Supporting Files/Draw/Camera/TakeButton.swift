//
//  TakeButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 9/3/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class TakeButton: UIButton {

    override var highlighted: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Private methods
    
    private var shouldHighlight: Bool {
        return highlighted || !enabled
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        drawTakePhoto(takeHighlight: shouldHighlight)
    }
    
    func drawTakePhoto(takeHighlight takeHighlight: Bool) {
        //// Color Declarations
        let primary = UIColor(red: 0.173, green: 0.243, blue: 0.314, alpha: 1.000)
        let primaryHighlighted = UIColor(red: 0.260, green: 0.344, blue: 0.413, alpha: 0.683)
        let color5 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(2, 1, 77, 77))
        color5.setStroke()
        ovalPath.lineWidth = 1.5
        ovalPath.stroke()
        
        
        //// Circle Drawing
        let circlePath = UIBezierPath(ovalInRect: CGRectMake(9, 8, 63, 63))
        primary.setFill()
        circlePath.fill()
        primaryHighlighted.setStroke()
        circlePath.lineWidth = 12
        circlePath.stroke()
        
        
        if (takeHighlight) {
            //// Circle 2 Drawing
            let circle2Path = UIBezierPath(ovalInRect: CGRectMake(15, 14, 51, 51))
            primaryHighlighted.setFill()
            circle2Path.fill()
        }
    }

    

}
