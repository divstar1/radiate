//
//  MapViewController.swift
//  Radiate
//
//  Created by dkarivarad on 8/21/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var locationSearchController:UISearchController? = nil
    var selectedLocation:MKPlacemark? = nil
    var locationSelectedCallback: LocationSelectedCallback? = nil
    
    override func viewDidLoad() {
        setUpLocationManager()
        setUpLocationSearchController()
    }
    
    func didSelectLocation(placemark:MKPlacemark) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        selectedLocation = placemark
    }
    
    @IBAction func saveLocation() {
        if let locationSelectedCallback = locationSelectedCallback,
            let selectedLocation = selectedLocation {
            locationSelectedCallback(selectedLocation)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func setUpLocationSearchController() {
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "MapSearchTableVC") as! MapSearchTableViewController
        locationSearchTable.mapView = mapView
        locationSearchTable.locationSelectedCallback = didSelectLocation(placemark:)
        locationSearchController = UISearchController(searchResultsController: locationSearchTable)
        locationSearchController?.searchResultsUpdater = locationSearchTable
        setUpSearchBar()
    }
    
    func setUpSearchBar() {
        let searchBar = locationSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search..."
        navigationItem.titleView = locationSearchController?.searchBar

        locationSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
    }
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
    
    
}
