//  AppDelegate.swift
//  informu

import UIKit
import CoreData
import CoreLocation
import UserNotifications

// ****************************************************************************************

@available(iOS 10.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
	
	var window: UIWindow?
	var locationManager: CLLocationManager?
	var lastProximity: CLProximity?
	
	// Override point for customization after application launch.
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
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
		let uuid = NSUUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")
		let beaconRegion = CLBeaconRegion(proximityUUID: uuid as! UUID, identifier: "Simblee")
		
		// When a device enters or exits the vicinity of a beacon
		locationManager?.startMonitoring(for: beaconRegion)
		
		//Bbegin receiving notifications when the relative distance to the beacon changes
		locationManager?.startRangingBeacons(in: beaconRegion)
	}
	
	// Scan for beacon and updateDistance if found
	// The location manager reports any encountered beacons to its delegate
	func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
		print(beacons)
		if beacons.count > 0 {
			let beacon = beacons.first! as CLBeacon
			updateDistance(distance: beacon.proximity)
		} else {
			updateDistance(distance: .unknown)
		}
	}
	
	// Regularly update UI with proximity
	func updateDistance(distance: CLProximity) {
//		UIView.animate(withDuration: 1) { [unowned self] in
			switch distance {
			case .unknown:
					print("unknown")
//				self.distanceLabel.text = "lost"
				self.createLocationNotification()
				
			case .far:
				print("far")
//				self.distanceLabel.text = "far"
				
			case .near:
				print("near")
//				self.distanceLabel.text = "near"
				
			case .immediate:
				print("immediate")
//				self.distanceLabel.text = "immediate"
			}
//		}
	}
	
	func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
		let notification = UILocalNotification()
		notification.alertBody = "didExitRegion"
		notification.applicationIconBadgeNumber = 0
		UIApplication.shared.presentLocalNotificationNow(notification)
	}
	
	func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
		// enterRegion
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
		let remindMeLaterAction = UIAlertAction(title: "Remind Me Later", style: .default, handler: nil)
		let sureAction = UIAlertAction(title: "Locate item", style: .default) { (action) in
			self.locationManager?.stopMonitoring(for: beaconRegion)
			self.locationManager?.stopRangingBeacons(in: beaconRegion)
		}
		
		alertController.addAction(sureAction)
		
		self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
	}
	
	func createLocationNotification() {
		// Fire off LocalNotification now.
		let localNotification = UILocalNotification()
		localNotification.fireDate = Date()
		
		localNotification.alertTitle = "Wallet lost."
		localNotification.applicationIconBadgeNumber = 0
		localNotification.soundName = UILocalNotificationDefaultSoundName
		localNotification.userInfo = ["message" : "Wallet lost."]
		localNotification.alertBody = "You have left an item behind."
		
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
		self.saveContext()
	}
	
	// MARK: - Core Data stack
	
	@available(iOS 10.0, *)
	lazy var persistentContainer: NSPersistentContainer = {
		/*
		The persistent container for the application. This implementation
		creates and returns a container, having loaded the store for the
		application to it. This property is optional since there are legitimate
		error conditions that could cause the creation of the store to fail.
		*/
		let container = NSPersistentContainer(name: "iBeacon")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				
				/*
				Typical reasons for an error here include:
				* The parent directory does not exist, cannot be created, or disallows writing.
				* The persistent store is not accessible, due to permissions or data protection when the device is locked.
				* The device is out of space.
				* The store could not be migrated to the current model version.
				Check the error message to determine what the actual problem was.
				*/
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	// MARK: - Core Data Saving support
	
	func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
	
}
