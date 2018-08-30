//
//  MapTableViewCell.swift
//  happens
//
//  Created by Vilvas, Inc. on 10/6/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {

    @IBOutlet var cellMapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Load On View
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
