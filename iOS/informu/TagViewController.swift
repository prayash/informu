//
//  TagViewController.swift
//  informu
//
//  Created by Prayash Thapa on 2/18/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TagViewController: UIViewController {
    
    var locationManager: CLLocationManager!
    var mapView: MKMapView!
    var tag: Tag?
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.title = tag?.name
        navigationItem.backButton.tintColor = muOrange
        
        createMapView()
        let tagSettingsButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(TagViewController.showSettings))
        tagSettingsButton.tintColor = muOrange
        navigationItem.rightBarButtonItems = [tagSettingsButton]
    }
    
    func createMapView() {
        mapView = MKMapView()
        
        let leftMargin: CGFloat = 10
        let topMargin: CGFloat = 60
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: view.frame.width, height: view.frame.height)
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        mapView.center = view.center
        
        // Show user location + zoom in
        mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: false);
        let userLocation = mapView.userLocation
        print(userLocation)
        
        view.addSubview(mapView)
    }
    
    func openMapForTag(lat: CLLocationDegrees, long: CLLocationDegrees) {
        let coordinate = CLLocationCoordinate2DMake(lat, long)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = "Target location"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    // 'lazy' = Only occurs once during the execution of the app
    lazy var settingsLauncher: TagSettingsLauncher = {
        let launcher = TagSettingsLauncher()
        launcher.tagViewController = self
        return launcher
    }()
    
    func showSettings() {
        settingsLauncher.tagViewController = self
        settingsLauncher.showSettings()
    }
    
    func showEditViewController(setting: Setting) {
        let editViewController = UIViewController()
        editViewController.view.backgroundColor = UIColor.white
        editViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.pushViewController(editViewController, animated: true)
    }
}
