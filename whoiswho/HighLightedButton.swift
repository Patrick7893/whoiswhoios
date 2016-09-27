//
//  HighLightedButton.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/26/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import UIKit

class HighLightedButton: UIButton {
    
    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = UIColor.lightGray
            } else {
                backgroundColor = UIColor.white
            }
        }
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
