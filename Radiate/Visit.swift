//
//  Visit.swift
//  Radiate
//
//  Created by dkarivarad on 8/21/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation

class Visit {
    let date: String
    let location: String
    let contacts: [String]
    
    init(date: String, location: String, contacts: [String]) {
        self.date = date
        self.location = location
        self.contacts = contacts
    }
}

extension Visit: Equatable {
    static func ==(lhs: Visit, rhs: Visit) -> Bool{
      return lhs.date == rhs.date &&
        lhs.location == rhs.location &&
        lhs.contacts == rhs.contacts
    }
}
