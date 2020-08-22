//
//  RecentContactsTableViewController.swift
//  Radiate
//
//  Created by dkarivarad on 8/22/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit
import ContactsUI

class RecentContactsTableViewController: UITableViewController {
    
    var recentContacts: [CNContact]?
    var selectedContacts = [CNContact]()

    var contactsSelectedCallback: ContactsSelectedCallback? = nil
    
    override func viewDidLoad() {
      super.viewDidLoad()
        recentContacts = getRecentContacts()
    }
    
    @IBAction func doneSelectingRecipients(_ sender: UIBarButtonItem) {
        if let contactsSelectedCallback = contactsSelectedCallback {
            contactsSelectedCallback(selectedContacts)
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let recentContacts = recentContacts {
            return recentContacts.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
      
      if let recentContacts = recentContacts, let cell = cell as? FriendCell {
        let friend = Friend(contact: recentContacts[indexPath.row])
        cell.friend = friend
      }
      return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        if let recentContacts = recentContacts {
            selectedContacts.append(recentContacts[indexPath.row])
        }
    }
}


