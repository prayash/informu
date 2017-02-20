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

class TagViewController: UIViewController, MKMapViewDelegate {
    
    var locationManager: CLLocationManager!
    var mapView: MKMapView!
    var tag: Tag?
    var destinationLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.title = tag?.name
        navigationItem.backButton.tintColor = muOrange
        
        createMapView()
        let tagSettingsButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(TagViewController.showSettings))
        tagSettingsButton.tintColor = muOrange
        navigationItem.rightBarButtonItems = [tagSettingsButton]
        setupToolbar()
    }
    
    func createMapView() {
        mapView = MKMapView()
        mapView.delegate = self
        
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
        
        let sourceLocation = CLLocationCoordinate2D(latitude: 39.848903, longitude: -104.674398)
        destinationLocation = CLLocationCoordinate2D(latitude: 39.847370, longitude: -104.680301)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "You"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = tag?.name
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        mapView.showAnnotations([sourceAnnotation, destinationAnnotation], animated: true)
        
        // 7.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .walking
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            self.mapView.setZoomByDelta(delta: 2, animated: true)
        }
        
        view.addSubview(mapView)
        
    }
    
    func openMaps() {
        openMapForTag(lat: destinationLocation.latitude, long: destinationLocation.longitude)
    }
    
    func openMapForTag(lat: CLLocationDegrees, long: CLLocationDegrees) {
        let coordinate = CLLocationCoordinate2DMake(lat, long)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.name = "Target location"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = muOrange
        renderer.lineWidth = 4.0
        return renderer
    }
    
    func setupToolbar() {
        self.navigationController?.isToolbarHidden = false
        let openMapsButton = UIBarButtonItem(title: "Open in Maps", style: .plain, target: self, action: #selector(openMaps))
        openMapsButton.tintColor = muOrange
        self.toolbarItems = [openMapsButton]
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

extension MKMapView {
    func setZoomByDelta(delta: Double, animated: Bool) {
        var _region = region;
        var _span = region.span;
        _span.latitudeDelta *= delta;
        _span.longitudeDelta *= delta;
        _region.span = _span;
        
        setRegion(_region, animated: animated)
    }
}
