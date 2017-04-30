//
//  Manager.swift
//  informu
//
//  Created by Prayash Thapa on 3/12/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CoreLocation
import UserNotifications

protocol ManagerDelegate: class {
    func didExitRegion(region: CLRegion)
    func didUpdateDistance(proximity: CLProximity)
}

class Manager: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = Manager()
    
    var dbRef: FIRDatabaseReference!
    let locationManager = CLLocationManager()
    weak var delegate: ManagerDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        
        FIRDatabase.database().persistenceEnabled = true
        dbRef = FIRDatabase.database().reference()
    }
    
    func start() {
        print("Starting location manager.")
        startScanning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated.")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedAlways || status == CLAuthorizationStatus.authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    // Initiate scanning
    func startScanning() {
        print("--> Manager is scanning for Mu tags. <--")
        let uuid = NSUUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid as! UUID, identifier: "Simblee")
        
        // When a device enters or exits the vicinity of a beacon
        locationManager.startMonitoring(for: beaconRegion)
        
        // Begin receiving notifications when the relative distance to the beacon changes
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    // Scan for beacon and updateDistance if found
    // The location manager reports any encountered beacons to its delegate
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            let beacon = beacons.first! as CLBeacon
            let distance = beacon.proximity
            
            delegate?.didUpdateDistance(proximity: distance)
        } else {
            delegate?.didUpdateDistance(proximity: .unknown)
        }
    }
    
    // - exitRegion
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        delegate?.didExitRegion(region: region)
        createLocationNotification()
    }
    
    // - enterRegion
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
    }
    
    func fetchTagsFromDatabase() {
        print("[ Updating mµ tags from database... ]")
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("Users").child("WL0hctUru4av5fGQ3F6XdXWAbpu2").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let tagName = dictionary["name"] as? String
                let tagColor = dictionary["color"] as? String
                let tagProximityUUID = dictionary["proximityUUID"] as? String
                let tagMajor = dictionary["major"] as? String
                let tagMinor = dictionary["minor"] as? String
                let tagLastSeen = dictionary["lastSeen"] as? String
                let tagLocation = dictionary["location"] as? String
                
                print("[ Mµ tags on device:", dictionary)
                
                DispatchQueue.main.async( execute: {
                    
                })
            }
            
            }, withCancel: nil)
    }
    
    func createLocationNotification() {
        // Fire off LocalNotification now.
        let localNotification = UILocalNotification()
        localNotification.fireDate = Date()
        localNotification.applicationIconBadgeNumber = 0
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.alertBody = "You have gone out of range with the mµ tag"
        
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        if (application.applicationState == .active) {
            
        }
        
        //self.takeActionWithNotification(localNotification: notification)
    }
    
}

