//
//  AppDelegate.swift
//  informu
//
//  Created by Prayash Thapa on 2/18/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit
import Material
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var locationManager: CLLocationManager?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: Screen.bounds)
        window!.rootViewController = NavController(rootViewController: HomeController())
        window!.makeKeyAndVisible()
        
        // Initialize locationManager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        let notificationSettings = UIUserNotificationSettings(types: [.badge, .alert, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
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
        print("[ Scanning from AppDelegate. . . ]")
        let uuid = NSUUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid as! UUID, identifier: "Simblee")
        
        // When a device enters or exits the vicinity of a beacon
        locationManager?.startMonitoring(for: beaconRegion)
        
        // Begin receiving notifications when the relative distance to the beacon changes
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
    
    // Scan for beacon and updateDistance if found
    // The location manager reports any encountered beacons to its delegate
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            let beacon = beacons.first! as CLBeacon
            let distance = beacon.proximity
            
            updateDistance(distance: distance)
        } else {
            updateDistance(distance: .unknown)
        }
    }
    
    // Regularly update UI with proximity
    func updateDistance(distance: CLProximity) {
        switch distance {
        case .unknown:
            print("out of range")
            
        case .far:
            print("farther away")
            
        case .near:
            print("nearby")
            
        case .immediate:
            print("immediate")
        }
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

