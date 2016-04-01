//
//  TutorTableViewCell.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 08/03/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import UIKit
import Material
class TutorTableViewCell: MaterialTableViewCell
{

    @IBOutlet var tutorlocation: UILabel!
    @IBOutlet var tutorPriceRange: UILabel!
    @IBOutlet var tutorDesc: UILabel!
    @IBOutlet var tutorName: UILabel!
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
