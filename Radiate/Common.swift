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
typealias ContactsSelectedCallback = ([CNContact]) -> Void

var userVisits = [Visit]()

func getRecentContacts() -> [CNContact] {
    let recentVisits = getRecentVisits()
    
    let allContacts = recentVisits.map {
        $0.contacts
    }.flatMap {
        $0
    }
    
    return Array(Set(allContacts))
}

func getRecentVisits() -> [Visit] {
    return userVisits.filter {
        visitIsRecent(visit: $0)
    }
}

func visitIsRecent(visit: Visit) -> Bool {
    if let twoWeeksAgo = Calendar.current.date(byAdding: .weekOfYear, value: -2, to: Date()) {
        return twoWeeksAgo < visit.date
    }
    
    return false
}

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
