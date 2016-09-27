//
//  Call.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/26/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import Foundation
import RealmSwift

class Call: Object {
    dynamic var number: String = ""
    dynamic var name: String = "hui"
    dynamic var date: NSDate = NSDate()
    dynamic var duration: String = ""
    dynamic var typeDescription: String = ""
    dynamic var callCount: Int = 1
    
    
}
