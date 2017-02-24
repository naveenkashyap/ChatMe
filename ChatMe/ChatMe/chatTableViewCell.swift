//
//  chatTableViewCell.swift
//  ChatMe
//
//  Created by Naveen Kashyap on 2/23/17.
//  Copyright © 2017 Naveen Kashyap. All rights reserved.
//

import UIKit
import Parse

class chatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var cellText: UILabel!
    var object: PFObject? {
        didSet{
            cellText.text = object?["text"] as? String
            let user = object?["user"] as? PFUser
            if user?.username != nil {
                userNameLabel.text = user?.username
                userNameLabel.isHidden = false
            } else {
                userNameLabel.isHidden = true
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
