//
//  AddVisitViewController.swift
//  Radiate
//
//  Created by dkarivarad on 8/21/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit

protocol LocationSelectHandler {
    func didSelectLocation(location:String)
}

class AddVisitViewController: UIViewController, UITextFieldDelegate, LocationSelectHandler {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var contactsTextField: UITextField!
    
    override func viewDidLoad() {
        locationTextField.delegate = self
    }
    
    func didSelectLocation(location: String) {
        locationTextField.text = location
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let mapNavController = storyboard?.instantiateViewController(withIdentifier: "mapNavController") as! UINavigationController
        let mapView = mapNavController.viewControllers.first as! MapViewController
        mapView.locationSearchHandlerDelegate = self
        
        present(mapNavController, animated: true, completion: nil)
    }

    
    @IBAction func didSelectContactsTextField() {
    }
}
