//
//  RoundedImageView.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/26/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 0.5 * self.bounds.size.width

    }

}
