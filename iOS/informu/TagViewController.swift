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
    let tag: Tag
    var destinationLocation: CLLocationCoordinate2D!
    
    var tagSnoozeButton: UIBarButtonItem!
    var luggageCheckInButton: UIButton!
    
    init(tag: Tag) {
        self.tag = tag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.title = tag.name
        navigationItem.backButton.tintColor = muOrange
        
        if tag.name != "Luggage" {
            createMapView()
        } else {
            createLuggageMapView()
        }
        
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
        
        let sourceLocation = CLLocationCoordinate2D(latitude: 40.007317, longitude: -105.263238)
        destinationLocation = CLLocationCoordinate2D(latitude: 40.007315, longitude: -105.263210)
        
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
        destinationAnnotation.title = tag.name
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        mapView.showAnnotations([sourceAnnotation], animated: true)
        
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
    
    func createLuggageMapView() {
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
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "You"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        mapView.showAnnotations([sourceAnnotation], animated: true)
        
        view.addSubview(mapView)
        
        luggageCheckInButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor(r: 224, g: 116, b: 43)
            button.setTitle("Reactivate Luggage", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.isHidden = true
            
            button.addTarget(self, action: #selector(snoozeAlert), for: .touchUpInside)
            
            return button
        }()
        
        view.addSubview(luggageCheckInButton)
        luggageCheckInButton.anchor(view.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: -120, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 60)
        
    }
    
    func openMaps() {
        openMapForTag(lat: destinationLocation.latitude, long: destinationLocation.longitude)
    }
    
    func snoozeAlert() {
        if tagSnoozeButton.title == "Reactivate" {
            let alert = UIAlertController(title: "Luggage reactivated", message: "You will now recieve alerts on your luggage.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default, handler:{ (UIAlertAction) in
                print("User reactivated tag.")
                self.tagSnoozeButton.title = "Check In"
                self.luggageCheckInButton.isHidden = true
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: {
                print("Popped up snooze alert.")
            })
        } else {
            let alert = UIAlertController(title: "Check in Luggage?", message: "This will disable alerts until you reactivate.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler:{ (UIAlertAction) in
                print("User snoozed tag.")
                self.tagSnoozeButton.title = "Reactivate"
                self.luggageCheckInButton.isHidden = false
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: {
                print("Popped up snooze alert.")
            })
        }

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
        navigationController?.isToolbarHidden = false
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        let openMapsButton = UIBarButtonItem(title: "Open in Maps", style: .plain, target: self, action: #selector(openMaps))
        openMapsButton.tintColor = muOrange
        
        tagSnoozeButton = UIBarButtonItem(title: "Check In", style: .plain, target: self, action: #selector(snoozeAlert))
        tagSnoozeButton.tintColor = muOrange
        
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        self.toolbarItems = [openMapsButton, flexibleItem, tagSnoozeButton]
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
