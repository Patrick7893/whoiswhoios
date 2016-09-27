//
//  PhoneCell.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/16/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import UIKit

class PhoneCell: UITableViewCell {
    
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //callImageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: Selector(("callTapped"))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func callTap(_ sender: AnyObject) {
        if let phoneNumber = PhoneFormatter.removeAllNonNUmeric(str: phoneLabel.text!) {
            let url:NSURL = NSURL(string: "tel://" + phoneNumber)!
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func messageTap(_ sender: AnyObject) {
        if let phoneNumber = PhoneFormatter.removeAllNonNUmeric(str: phoneLabel.text!) {
            let url:NSURL = NSURL(string: "sms://" + phoneNumber)!
            UIApplication.shared.openURL(url as URL)
        }
    }
    
   
}
