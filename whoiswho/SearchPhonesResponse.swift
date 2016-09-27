//
//  SearchPhonesResponse.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/20/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import Foundation
import JSONJoy

class SearchPhonesResponse: JSONJoy  {
    var error: Int = -1
    var data: [Phone] = []
    
    
    required init(_ decoder: JSONDecoder) throws {
        error = try decoder["error"].getInt()
        guard let phones = decoder["data"].array else {
            throw JSONError.wrongType
        }
        var collect = [Phone]()
        for phone in phones {
            try collect.append(Phone(phone))
        }
        data = collect
    }
}
