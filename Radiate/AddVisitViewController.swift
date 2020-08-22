//
//  AddVisitViewController.swift
//  Radiate
//
//  Created by dkarivarad on 8/21/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import ContactsUI

class AddVisitViewController: UIViewController, UITextFieldDelegate, CNContactPickerDelegate {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var contactsTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var selectedLocation:MKPlacemark?
    var contacts:[CNContact]?
    var visitCreatedCallback: VisitCreatedCallback? = nil

    override func viewDidLoad() {
        locationTextField.delegate = self
        contactsTextField.delegate = self
    }
    
    @IBAction func addVisitClicked() {
        // Verify fields
        if (locationTextField.text != "" && contactsTextField.text != "") {
            
            if let selectedLocation = selectedLocation,
                let contacts = contacts {
                let visit = Visit(date: datePicker.date, location: selectedLocation, contacts: contacts)
                userVisits.append(visit)
                
                if let visitCreatedCallback = visitCreatedCallback {
                    visitCreatedCallback()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            displayFieldAlert()
        }
    }
    
    func didSelectLocation(placemark: MKPlacemark) {
        locationTextField.text = "\(placemark.name ?? "Unknown place") at \(placemark.title ?? "Unknown address")"
        selectedLocation = placemark
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == locationTextField {
            handleMap()
        } else if textField == contactsTextField {
            handleContacts()
        }
    }
    
    func handleMap() {
        let mapNavController = storyboard?.instantiateViewController(withIdentifier: "mapNavController") as! UINavigationController
        let mapView = mapNavController.viewControllers.first as! MapViewController
        mapView.locationSelectedCallback = didSelectLocation(placemark:)
        
        present(mapNavController, animated: true, completion: nil)
    }

    func handleContacts() {
        contactsTextField.resignFirstResponder()
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.predicateForEnablingContact = NSPredicate(
          format: "phoneNumbers.@count > 0")
        present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contactsTextField.text = getContactsString(contacts: contacts)
        self.contacts = contacts
        picker.dismiss(animated: true, completion: nil)
    }
    
    func displayFieldAlert() {
        let alertController = UIAlertController(title: "Error", message:
            "Please fill out all the fields to create a visit.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
