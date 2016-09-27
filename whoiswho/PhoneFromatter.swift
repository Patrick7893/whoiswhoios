//
//  PhoneFromatter.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/19/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import Foundation
import CoreTelephony

class PhoneFormatter {
    
    static func removeAllNonNUmeric(str: String) -> String? {
        return String(str.characters.filter { String($0).rangeOfCharacter(from: NSCharacterSet(charactersIn: "0123456789+") as CharacterSet) != nil })
    }
    
    static func getSimCOuntryIso() -> String? {
        let ctcar = CTTelephonyNetworkInfo().subscriberCellularProvider
        return ctcar?.isoCountryCode
    }
    
}
