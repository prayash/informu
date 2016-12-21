//  AppDelegate.swift
//  informu

import UIKit
import Firebase
import CoreLocation
import UserNotifications

// ****************************************************************************************

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
	
	var window: UIWindow?
	var locationManager: CLLocationManager?
	
	var tags = [Tag]()
	var tagsTableViewController: TagsTableViewController = TagsTableViewController()
	
	//var addTagController: AddTagController = AddTagController()
	var proximityMessage: String = "Searching..."
	
	// Override point for customization after application launch.
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		// Initialize Firebase
		FIRApp.configure()

		// Initialize locationManager
		locationManager = CLLocationManager()
		locationManager?.delegate = self
		locationManager?.requestAlwaysAuthorization()
		
		let notificationSettings = UIUserNotificationSettings(types: [.badge, .alert, .sound], categories: nil)
		UIApplication.shared.registerUserNotificationSettings(notificationSettings)

		return true
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
			
			//print(addTagController)
			//addTagController.showAvailableTags(beacon: beacon)
			// This is seriously so hacky.. must figure out a better way to do this!
			//print(UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[0].presentedViewController?.childViewControllers.isEmpty)
			
			if UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[0].presentedViewController?.childViewControllers.isEmpty == false  {
				if let addTagController = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[0].presentedViewController?.childViewControllers[0] as? AddTagController {
						addTagController.showAvailableTags(beacon: beacon)
				}
			}
			
//			if (UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[0].presentedViewController != nil && UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[0].presentedViewController?.childViewControllers != nil) {
//				if let addTagController = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[0].presentedViewController?.childViewControllers[0] as? AddTagController {
//					addTagController.showAvailableTags(beacon: beacon)
//				}
//			}
//			if let addTagController = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[0].presentedViewController?.childViewControllers[0] as? AddTagController {
//				addTagController.showAvailableTags(beacon: beacon)
//			}
			
			for i in 0..<self.tags.count {
				 self.tags[i].location = proximityMessage
				
				UIView.performWithoutAnimation {
					self.tagsTableViewController.tableView.reloadData()
//					let indexPath = IndexPath(item: 0, section: 0)
//					self.tagsTableViewController.tableView.reloadRows(at: [indexPath], with: .top)
				}
			}
			
			updateDistance(distance: distance)
		} else {
			updateDistance(distance: .unknown)
		}
	}
	
	// Regularly update UI with proximity
	func updateDistance(distance: CLProximity) {
		UIView.animate(withDuration: 1) { [unowned self] in
			switch distance {
			case .unknown:
				self.proximityMessage = "Lost"
//				self.createLocationNotification()
				
			case .far:
				self.proximityMessage = "Farther Away"
				
			case .near:
				self.proximityMessage = "Nearby"
				
			case .immediate:
				self.proximityMessage = "Immediate"
			}
		}
	}
	
	// - exitRegion
	func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//		let notification = UILocalNotification()
//		notification.alertBody = "You have gone out of range with the mµ tag."
//		notification.applicationIconBadgeNumber = 0
//		UIApplication.shared.presentLocalNotificationNow(notification)
		
		createLocationNotification()
	}
	
	// - enterRegion
	func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//		let notification = UILocalNotification()
//		notification.alertBody = "You have come into range with the mµ tag."
//		notification.applicationIconBadgeNumber = 0
//		UIApplication.shared.presentLocalNotificationNow(notification)
	}
	
	func parseProximity(distance: CLProximity) -> String {
		switch distance {
		case .unknown:
			return "Lost"
			
		case .far:
			return "Far"
			
		case .near:
			return "Nearby"
			
		case .immediate:
			return "Immediate"
		}
	}
	
	func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
		if (application.applicationState == .active) {
			
		}
		
		self.takeActionWithNotification(localNotification: notification)
	}
	
	func takeActionWithNotification(localNotification: UILocalNotification) {
		let notificationMessage = localNotification.userInfo!["message"] as! String
		let uuid = NSUUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")
		let beaconRegion = CLBeaconRegion(proximityUUID: uuid as! UUID, identifier: "Simblee")
		let alertController = UIAlertController(title: "Alert!", message: notificationMessage, preferredStyle: .alert)
		// let remindMeLaterAction = UIAlertAction(title: "Remind Me Later", style: .default, handler: nil)
		let sureAction = UIAlertAction(title: "Okay.", style: .default) { (action) in
//			self.locationManager?.stopMonitoring(for: beaconRegion)
//			self.locationManager?.stopRangingBeacons(in: beaconRegion)
		}
		
		alertController.addAction(sureAction)
		
		self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
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
		// Saves changes in the application's managed object context before the application terminates.
	}
}
