//
//  Visit.swift
//  Radiate
//
//  Created by dkarivarad on 8/21/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit
import ContactsUI
import MapKit

class Visit {
    let date: Date
    let location: MKPlacemark
    let contacts: [CNContact]
    
    init(date: Date, location: MKPlacemark, contacts: [CNContact]) {
        self.date = date
        self.location = location
        self.contacts = contacts
    }
}
