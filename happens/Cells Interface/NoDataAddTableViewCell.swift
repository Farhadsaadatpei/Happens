//
//  NoDataAddTableViewCell.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/8/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit

class NoDataAddTableViewCell: UITableViewCell {

    @IBOutlet var Container: UIView!
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        Container.layer.shadowColor = UIColor.blackColor().CGColor
        Container.layer.shadowOpacity = 0.3
        Container.layer.masksToBounds = false
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
