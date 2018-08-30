//
//  DefaultButton.swift
//  happens
//
//  Created by Vilvas, Inc. on 11/1/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class DefaultButton: UIButton {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawDefaultButton(frame: self.bounds)
    }
    
    var Color: UIColor!
    @IBInspectable var ButtonBackgroundColor: UIColor = UIColor.whiteColor(){
        didSet {
            Color = ButtonBackgroundColor
        }
    }
    
    var defaultText: String!
    @IBInspectable var text: String = "Button"{
        didSet {
            defaultText = text
        }
    }
    
    var textSizeDefault: CGFloat!
    @IBInspectable var textSize: CGFloat = 12{
        didSet {
            textSizeDefault = textSize
        }
    }
    
    func drawDefaultButton(frame frame: CGRect = CGRectMake(0, 0, 140, 64)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let primary = Color
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath()
        rectanglePath.moveToPoint(CGPointMake(frame.minX + 0.10893 * frame.width, frame.minY + 0.80469 * frame.height))
        rectanglePath.addLineToPoint(CGPointMake(frame.minX + 0.90357 * frame.width, frame.minY + 0.80469 * frame.height))
        rectanglePath.addLineToPoint(CGPointMake(frame.minX + 0.90357 * frame.width, frame.minY + 0.19531 * frame.height))
        rectanglePath.addLineToPoint(CGPointMake(frame.minX + 0.10893 * frame.width, frame.minY + 0.19531 * frame.height))
        rectanglePath.addLineToPoint(CGPointMake(frame.minX + 0.10893 * frame.width, frame.minY + 0.80469 * frame.height))
        rectanglePath.closePath()
        rectanglePath.lineCapStyle = .Round;
        
        rectanglePath.lineJoinStyle = .Round;
        
        primary.setFill()
        rectanglePath.fill()
        primary.setStroke()
        rectanglePath.lineWidth = 13
        rectanglePath.stroke()
        
        
        //// Text Drawing
        let textRect = CGRectMake(frame.minX + floor(frame.width * 0.07857 + 0.5), frame.minY + floor(frame.height * 0.18750 + 0.5), floor(frame.width * 0.92857 + 0.5) - floor(frame.width * 0.07857 + 0.5), floor(frame.height * 0.79688 + 0.5) - floor(frame.height * 0.18750 + 0.5))
        let textTextContent = NSString(string: defaultText)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Center
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(textSizeDefault), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
    }


}
