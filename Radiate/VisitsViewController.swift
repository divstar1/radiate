/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

//
//  VisitsViewController.swift
//  Radiate
//
//  Created by dkarivarad on 8/21/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit

typealias VisitCreatedCallback = () -> Void

class VisitsViewController: UITableViewController {
    
    var visits:[Visit]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.visits = userVisits
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "My Visits"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "VisitCell", for: indexPath) as! VisitCell
        if let visits = visits {
            let currentVisit = visits[indexPath.item]
            cell.contactsLabel.text = getContactsString(contacts: currentVisit.contacts)
            cell.locationLabel.text = getLocationString(location: currentVisit.location)
            cell.dateLabel.text = getDateString(date: currentVisit.date)
        }
      return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let visits = visits {
            return visits.count
        } else {
            return 0
        }
    }
    
    func reloadData() {
        self.visits = userVisits
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    @IBAction func createVisitClicked(_ sender: UIBarButtonItem) {
        let addVisitController = storyboard?.instantiateViewController(withIdentifier: "addVisitController") as! AddVisitViewController
        addVisitController.visitCreatedCallback = reloadData
        
        present(addVisitController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.navigationBar.tintColor = .white
    }
}
