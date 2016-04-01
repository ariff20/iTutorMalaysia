//
//  TutorFavoriteTableViewCell.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 25/03/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import UIKit

class TutorFavoriteTableViewCell: UITableViewCell {

    @IBOutlet var tutorgender: UILabel!
    @IBOutlet var tutorstate: UILabel!
    @IBOutlet var tutorprice: UILabel!
    @IBOutlet var tutorphoneno: UILabel!
    @IBOutlet var tutorname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
