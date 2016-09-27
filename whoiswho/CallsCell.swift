//
//  CallsCell.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/26/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import UIKit

class CallsCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
