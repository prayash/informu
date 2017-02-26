//
//  Manager.swift
//  informu
//
//  Created by Prayash Thapa on 2/25/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

protocol TagRangeManagerDelegate: class {
	func didExitRegion(_ region: CLRegion)
}

class TagRangeManager: NSObject, CLLocationManagerDelegate {
	static let manager = TagRangeManager()
	
	let locationManager = CLLocationManager()
	weak var delegate: TagRangeManagerDelegate?
	
	override init() {
		super.init()
		locationManager.delegate = self
		
		if CLLocationManager.authorizationStatus() == .notDetermined {
			locationManager.requestAlwaysAuthorization()
		}
	}
	
	func start() {
		print("Starting location manager.")
		startScanning()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		print("Location updated.")
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		guard status == CLAuthorizationStatus.authorizedAlways || status == CLAuthorizationStatus.authorizedWhenInUse, CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self), CLLocationManager.isRangingAvailable() else { return }
		
			startScanning()
	}
	
	// Initiate scanning
	func startScanning() {
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
//			let beacon = beacons.first! as CLBeacon
//			let distance = beacon.proximity
			
//			if UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[0].presentedViewController?.childViewControllers.isEmpty == false  {
//				if let addTagController = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[0].presentedViewController?.childViewControllers[0] as? AddTagController {
//					addTagController.showAvailableTags(beacon: beacon)
//				}
//			}
			
			
//			for i in 0..<self.tags.count {
//				self.tags[i].location = proximityMessage
//				self.tags[i].lastSeen = lastSeenMessage
//				
//				UIView.performWithoutAnimation {
//					self.tagsTableViewController.tableView.reloadData()
//					//					let indexPath = IndexPath(item: 0, section: 0)
//					//					self.tagsTableViewController.tableView.reloadRows(at: [indexPath], with: .top)
//				}
//			}
//			
//			updateDistance(distance: distance)
//		} else {
//			updateDistance(distance: .unknown)
		}
	}
	
	// - exitRegion
	func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
		delegate?.didExitRegion(region)
		createLocationNotification()
	}
	
	// - enterRegion
	func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {

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
