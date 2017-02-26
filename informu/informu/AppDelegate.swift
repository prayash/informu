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
	
	var proximityMessage: String = "Searching..."
	var lastSeenMessage: String = "Just Now"
	var timer = Timer()
	var pingTime = Date()
	
	// Override point for customization after application launch.
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		// Init Firebase
		FIRApp.configure()
		TagRangeManager.manager.start()
		
		let notificationSettings = UIUserNotificationSettings(types: [.badge, .alert, .sound], categories: nil)
		UIApplication.shared.registerUserNotificationSettings(notificationSettings)

		return true
	}
	
	// Regularly update UI with proximity
	func updateDistance(distance: CLProximity) {
		switch distance {
		case .unknown:
			self.pingTime = Date()
			self.proximityMessage = "Lost"
//			self.createLocationNotification()
			
		case .far:
			self.pingTime = Date()
			self.proximityMessage = "Farther away"
			
		case .near:
			self.pingTime = Date()
			self.proximityMessage = "Nearby"
			
		case .immediate:
			self.pingTime = Date()
			self.proximityMessage = "Safe"
		}
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
