//
//  SignUpViewController.swift
//  Radiate
//
//  Created by dkarivarad on 8/21/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: true);

        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    @IBAction func didClickSignUpButton() {
        if (nameTextField.text != "" && phoneNumberTextField.text != "" && passwordTextField.text != "") {
            goToTabController()
        } else {
            displayFieldAlert()
        }
    }
    
    func goToTabController() {
        let tabbarVC = storyboard?.instantiateViewController(withIdentifier: "TabbarVC") as! UITabBarController
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    func displayFieldAlert() {
        let alertController = UIAlertController(title: "Error", message:
            "Please fill out all the fields to sign up.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
}
