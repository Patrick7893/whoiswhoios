//
//  ActionCell.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/16/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import UIKit

class ActionCell: UITableViewCell {
    
    @IBOutlet weak var actionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
