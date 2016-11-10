//  ViewController.swift
//  informu

import UIKit
import CoreLocation
import UserNotifications

class ViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
	@IBOutlet weak var distanceLabel: UILabel!
	@IBOutlet var addTagPopUp: UIView!
	@IBOutlet weak var visualEffectView: UIVisualEffectView!
	
	@IBAction func addTag(_ sender: AnyObject) {
		animateIn()
	}
	@IBAction func doneAddTag(_ sender: AnyObject) {
		animateOut();
	}
	@IBOutlet weak var tagCollectionView: UICollectionView!
	
	let tags = ["µ1", "µ2"]
	let imageArray = [UIImage(named: "mu1"), UIImage(named: "mu2")]
	
	// Central point for configuring the delivery of location-related events to the application
	var locationManager: CLLocationManager!
	
	// Blur effect
	var effect:UIVisualEffect!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Deactivate blur visual effect
		effect = visualEffectView.effect
		visualEffectView.effect = nil
		
		// Add corner radius to addTagPopUp
		addTagPopUp.layer.cornerRadius = 5
		
		// Initialize locationManager
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.requestAlwaysAuthorization()
		
		// Set navigation bar color
		self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0xff704c)
	}
	
	// Animate addTagPopUp
	func animateIn() {
		// Enter view
		self.view.addSubview(addTagPopUp)
		addTagPopUp.center = self.view.center
		
		// Initial animation state
		addTagPopUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
		addTagPopUp.alpha = 0
		
		UIView.animate(withDuration: 0.4) {
			// Use self because we are within a closure
			self.visualEffectView.effect = self.effect
			self.addTagPopUp.alpha = 1
			self.addTagPopUp.transform = CGAffineTransform.identity
		}
	}
	
	// Animate addTagPopUp (exit)
	func animateOut() {
		UIView.animate(withDuration: 0.3, animations: {
			self.addTagPopUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
			self.addTagPopUp.alpha = 0
			self.visualEffectView.effect = nil
			}) { (success:Bool) in
					self.addTagPopUp.removeFromSuperview()
			}
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
		
		locationManager.startMonitoring(for: beaconRegion)
		locationManager.startRangingBeacons(in: beaconRegion)
	}
	
	// Scan for beacon and updateDistance if found
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
		UIView.animate(withDuration: 1) { [unowned self] in
			switch distance {
				case .unknown:
					self.view.backgroundColor = UIColor.gray
					self.distanceLabel.text = "LOST"
					// self.createLocationNotification()
				
				case .far:
					self.view.backgroundColor = UIColor.blue
					self.distanceLabel.text = "FAR"

				case .near:
					self.view.backgroundColor = UIColor.red
					self.distanceLabel.text = "NEAR"

				case .immediate:
					let mOrange = UIColor(rgb: 0x424242)
					self.view.backgroundColor = mOrange
					self.distanceLabel.text = "IMMEDIATE"
			}
		}
	}
	
	// Helper to send local notification
	func createLocationNotification() {
		let localNotification = UILocalNotification()
		localNotification.fireDate = Date()
		localNotification.soundName = UILocalNotificationDefaultSoundName
		localNotification.userInfo = [
			"message" : "µ lost."
		]
		
		localNotification.alertBody = "Lost!"
		UIApplication.shared.scheduleLocalNotification(localNotification)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.tags.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let tag = collectionView.dequeueReusableCell(withReuseIdentifier: "tag", for: indexPath) as! CollectionViewCell
		tag.imageView?.image = self.imageArray[indexPath.row]
		tag.tagName?.text = self.tags[indexPath.row]
		
		
		return tag
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "showTag", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showTag" {
			// Get # of items selected in collectioni view
			let indexPaths = self.tagCollectionView!.indexPathsForSelectedItems!
			
			// Get first item and set that as index path
			let indexPath = indexPaths[0] as NSIndexPath
			
			// Get the destination VC and cast it as new VC
			let vc = segue.destination as! TagViewController
			
			// Set the respective parameters
			vc.image = self.imageArray[indexPath.row]!
			vc.title = self.tags[indexPath.row]
		}
	}

}

// Extension to define colors using hex values
extension UIColor {
	convenience init(rgb:UInt, alpha:CGFloat = 1.0) {
		self.init(
			red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgb & 0x0000FF) / 255.0,
			alpha: CGFloat(alpha)
		)
	}
}
