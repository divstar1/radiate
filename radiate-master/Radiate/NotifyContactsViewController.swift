//
//  NotifyContactsViewController.swift
//  Radiate
//
//  Created by dkarivarad on 8/22/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit

class NotifyContactsViewController: UIViewController {
    
    @IBAction func userTestedPositiveClicked() {
        userTestedPositive = true
    }
    
    @IBAction func usersContactTestedPositiveClicked() {
        userTestedPositive = false
    }
    
    override func viewDidLoad() {
        
    }
}
