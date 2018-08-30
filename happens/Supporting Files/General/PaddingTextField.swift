//
//  PaddingTextField.swift
//  happens
//
//  Created by Vilvas, Inc. on 8/17/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class PaddingTextField: UITextField {
    
    @IBInspectable var insetLeftRight: CGFloat = 0
    @IBInspectable var insetTopBottom: CGFloat = 0
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        super.textRectForBounds(bounds)
        return CGRectInset(bounds, insetLeftRight, insetTopBottom)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        super.editingRectForBounds(bounds)
        return textRectForBounds(bounds)
    }
    
}
