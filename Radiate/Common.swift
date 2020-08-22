//
//  Common.swift
//  Radiate
//
//  Created by dkarivarad on 8/21/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import ContactsUI

let RADIATE_BLUE = UIColor(red: 0.74, green: 0.89, blue: 0.97, alpha: 1.00)

typealias LocationSelectedCallback = (MKPlacemark) -> Void

var userVisits = [Visit]()

func getDateString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd"
    
    return dateFormatter.string(from: date)
}

func getLocationString(location: MKPlacemark) -> String {
    return "\(location.name ?? "Unknown place"))"
}

func getContactsString(contacts: [CNContact]) -> String {
    let contactNames = contacts.map { (contact) -> String in
        contact.givenName
    }
    return contactNames.joined(separator:", ")
}
