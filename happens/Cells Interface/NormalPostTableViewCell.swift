//
//  NormalPostTableViewCell.swift
//  happens
//
//  Created by Vilvas, Inc. on 6/16/15.
//  Copyright © 2015 Vilvas, Inc. All rights reserved.
//

import UIKit
import MapKit

@objc protocol  NormalPostTableViewCellDelegate {
    optional func voteUp(cell: NormalPostTableViewCell)
    optional func voteDown(cell: NormalPostTableViewCell)
    optional func Comments(cell: NormalPostTableViewCell)
}

class NormalPostTableViewCell: UITableViewCell {
    
    var delegate: NormalPostTableViewCellDelegate?
    
    @IBOutlet var ContentView: UIView!
    @IBOutlet weak var postStatus: UITextView!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet var postLocationButton: UIButton!
    @IBOutlet weak var postLocation: UILabel!
    @IBOutlet var SelfPostIndicator: SelfIndicator!
    @IBOutlet weak var ActionDetail: UIView!
    @IBOutlet weak var postRankView: UIView!
    @IBOutlet weak var postComment: UIButton!
    
    //Comment System
    @IBOutlet weak var numberOfComments: UILabel!
    
    //Voting System
    @IBOutlet weak var numberOfVotes: UILabel!
    @IBOutlet weak var upVoteButton: UIButton!
    @IBOutlet weak var downVoteButton: UIButton!
    
    //Photo Content
    @IBOutlet weak var postPhotoWrapper: UIView!
    @IBOutlet weak var postPhoto: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func Comments(sender: AnyObject) {
        delegate?.Comments!(self)
    }
    
    @IBAction func voteUp(sender: AnyObject) {
        delegate?.voteUp!(self)
    }
    
    @IBAction func voteDown(sender: AnyObject) {
        delegate?.voteDown!(self)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
