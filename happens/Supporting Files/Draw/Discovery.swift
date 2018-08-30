//
//  Discovery.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/5/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

@IBDesignable class Discovery: UIButton {


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawLocationDiscovery(frame: self.bounds)
    }

    
    
    func drawLocationDiscovery(frame frame: CGRect) {
        //// Color Declarations
        let primary = UIColor(red: 0.173, green: 0.243, blue: 0.314, alpha: 1.000)
        let fillColor3 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        
        //// Subframes
        let map_location_service_outline_stroke: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.15106 + 0.5), frame.minY + floor(frame.height * 0.20213 + 0.5), floor(frame.width * 0.78511 + 0.5) - floor(frame.width * 0.15106 + 0.5), floor(frame.height * 0.83830 + 0.5) - floor(frame.height * 0.20213 + 0.5))
        
        //// path-1 Drawing
        let path1Path = UIBezierPath()
        path1Path.moveToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.00000 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.34091 * map_location_service_outline_stroke.height))
        path1Path.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.50000 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.49815 * map_location_service_outline_stroke.height))
        path1Path.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.65909 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 1.00000 * map_location_service_outline_stroke.height))
        path1Path.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 1.00000 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.00000 * map_location_service_outline_stroke.height))
        path1Path.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.00000 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.34091 * map_location_service_outline_stroke.height))
        path1Path.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.00000 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.34091 * map_location_service_outline_stroke.height))
        path1Path.closePath()
        path1Path.moveToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.11417 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.34243 * map_location_service_outline_stroke.height))
        path1Path.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.53409 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.46591 * map_location_service_outline_stroke.height))
        path1Path.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.65909 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.86364 * map_location_service_outline_stroke.height))
        path1Path.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.93182 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.06818 * map_location_service_outline_stroke.height))
        path1Path.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.11417 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.34243 * map_location_service_outline_stroke.height))
        path1Path.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.11417 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.34243 * map_location_service_outline_stroke.height))
        path1Path.closePath()
        path1Path.miterLimit = 4;
        
        path1Path.usesEvenOddFillRule = true;
        
        fillColor3.setFill()
        path1Path.fill()
        
        
        //// path- Drawing
        let pathPath = UIBezierPath()
        pathPath.moveToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.00000 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.34091 * map_location_service_outline_stroke.height))
        pathPath.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.50000 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.49815 * map_location_service_outline_stroke.height))
        pathPath.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.65909 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 1.00000 * map_location_service_outline_stroke.height))
        pathPath.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 1.00000 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.00000 * map_location_service_outline_stroke.height))
        pathPath.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.00000 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.34091 * map_location_service_outline_stroke.height))
        pathPath.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.00000 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.34091 * map_location_service_outline_stroke.height))
        pathPath.closePath()
        pathPath.moveToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.11417 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.34243 * map_location_service_outline_stroke.height))
        pathPath.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.53409 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.46591 * map_location_service_outline_stroke.height))
        pathPath.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.65909 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.86364 * map_location_service_outline_stroke.height))
        pathPath.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.93182 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.06818 * map_location_service_outline_stroke.height))
        pathPath.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.11417 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.34243 * map_location_service_outline_stroke.height))
        pathPath.addLineToPoint(CGPointMake(map_location_service_outline_stroke.minX + 0.11417 * map_location_service_outline_stroke.width, map_location_service_outline_stroke.minY + 0.34243 * map_location_service_outline_stroke.height))
        pathPath.closePath()
        pathPath.miterLimit = 4;
        
        pathPath.usesEvenOddFillRule = true;
        
        primary.setFill()
        pathPath.fill()
    }



}
