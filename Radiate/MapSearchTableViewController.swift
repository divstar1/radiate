//
//  MapSearchTable.swift
//  Radiate
//
//  Created by dkarivarad on 8/21/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class MapSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    var mapSearchHandlerDelegate:MapSearchHandler? = nil

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        mapSearchHandlerDelegate?.didSelectLocation(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = "\(selectedItem.name ?? "Unknown place")"
        cell.detailTextLabel?.text = "\(selectedItem.title ?? "Unknown address")"
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
        let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        
    }
}
