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

class AddVisitViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var contactsTextField: UITextField!
    
    override func viewDidLoad() {
        locationTextField.delegate = self
    }
    
    func didSelectLocation(placemark: MKPlacemark) {
        locationTextField.text = "\(placemark.name ?? "Unknown place") at \(placemark.title ?? "Unknown address")"
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let mapNavController = storyboard?.instantiateViewController(withIdentifier: "mapNavController") as! UINavigationController
        let mapView = mapNavController.viewControllers.first as! MapViewController
        mapView.locationSelectedCallback = didSelectLocation(placemark:)
        
        present(mapNavController, animated: true, completion: nil)
    }

    
    @IBAction func didSelectContactsTextField() {
    }
}
