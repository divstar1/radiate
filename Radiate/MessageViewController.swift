//
//  MessageViewController.swift
//  Radiate
//
//  Created by dkarivarad on 8/21/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit
import ContactsUI

class MessageViewController: UIViewController, UITextViewDelegate, CNContactPickerDelegate {
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        messageTextView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func contactsSelected(contacts: [CNContact]) {
        
    }
    
    @IBAction func selectContactsClicked() {
        let contactsNavController = storyboard?.instantiateViewController(withIdentifier: "contactsNavController") as! UINavigationController
        let recentContactsController = contactsNavController.viewControllers.first as! RecentContactsTableViewController
        recentContactsController.contactsSelectedCallback = contactsSelected(contacts:)

        present(contactsNavController, animated: true, completion: nil)
    }
    
}
