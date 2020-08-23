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
import MessageUI

class MessageViewController: UIViewController, UITextViewDelegate, CNContactPickerDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var diagnosisDatePicker: UIDatePicker!
    @IBOutlet weak var diagnosisDateLabel: UILabel!
    
    var selectedContacts: [CNContact]?
    
    override func viewDidLoad() {
        if (!userTestedPositive) {
            diagnosisDatePicker.isHidden = true
            diagnosisDateLabel.isHidden = true
        }
        
        messageTextView.delegate = self
        
        addMessageTextViewBorder()
        messageTextView.text = getTextMessageBody(for: nil)
    }
    
    @IBAction func diagnosisDateChanged(_ sender: UIDatePicker) {
        if (userTestedPositive) {
            messageTextView.text = getTextMessageBody(for: sender.date)
        }
       }
    
    func addMessageTextViewBorder() {
        messageTextView.layer.borderWidth = 1
        messageTextView.layer.cornerRadius = 7
        messageTextView.layer.borderColor = RADIATE_BLUE.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func contactsSelected(contacts: [CNContact]) {
        selectedContacts = contacts
    }
    
    @IBAction func notifyContacts() {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = messageTextView.text;
        messageVC.recipients = selectedContacts?.map({ (contact) -> String in
            if let phoneNumber = contact.phoneNumbers.first {
                return phoneNumber.value.stringValue
            } else {
                return "Unknown number"
            }
        })
        messageVC.messageComposeDelegate = self
        
        self.present(messageVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
            case .cancelled:
                print("Message was cancelled")
                dismiss(animated: true, completion: nil)
            case .failed:
                print("Message failed")
                dismiss(animated: true, completion: nil)
            case .sent:
                print("Message was sent")
                dismiss(animated: true, completion: nil)
            default:
                break
            }
    }
    
    
    @IBAction func selectContactsClicked() {
        let contactsNavController = storyboard?.instantiateViewController(withIdentifier: "contactsNavController") as! UINavigationController
        let recentContactsController = contactsNavController.viewControllers.first as! RecentContactsTableViewController
        recentContactsController.contactsSelectedCallback = contactsSelected(contacts:)

        present(contactsNavController, animated: true, completion: nil)
    }
    
}
