//
//  Phone.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/20/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import Foundation
import JSONJoy
import RealmSwift

class Phone: JSONJoy {
    var serverId: Int = 0
    var number: String = ""
    var typeOfNumber: Int = 0
    var name: String = ""
    var countryIso: String = ""
    var avatar: String = ""
    var numberOfSettedSpamn: Int = 0
    
    required init(_ decoder: JSONDecoder) throws {
        serverId = try decoder["id"].getInt()
        number = try decoder["number"].getString()
        typeOfNumber = try decoder["typeOfNumber"].getInt()
        name = try decoder["name"].getString()
        countryIso = try decoder["countryIso"].getString()
        numberOfSettedSpamn = try decoder["number_of_setted_spam"].getInt()
    }
    
}
