//
//  VisitCell.swift
//  Radiate
//
//  Created by dkarivarad on 8/21/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit

class VisitCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var contactsLabel: UILabel!
    
    var visit : Visit? {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        
    }
    
}
