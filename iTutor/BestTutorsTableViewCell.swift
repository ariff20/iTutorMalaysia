//
//  BestTutorsTableViewCell.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 09/04/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import UIKit
import Cosmos
class BestTutorsTableViewCell: UITableViewCell {

    @IBOutlet var tutorstate: UILabel!
    @IBOutlet var tutorrating: CosmosView!
    @IBOutlet var tutorpricerange: UILabel!
    @IBOutlet var tutordescription: UILabel!
    @IBOutlet var tutorname: UILabel!
    @IBOutlet var tutorimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
