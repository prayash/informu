// informu
// TagViewController.swift
// This View shows details of the µ tag. It displays information about the specific tag.
// It also shows the user's current location and the tag's location.

import UIKit
import MapKit

// ****************************************************************************************

class TagViewController: UIViewController {
	
	@IBOutlet weak var mapView: MKMapView!
	
	var image = UIImage()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Show user location + zoom in
		mapView.showsUserLocation = true
		self.mapView.setUserTrackingMode(.follow, animated: false);
		let userLocation = mapView.userLocation
		print(userLocation)
		let tagSettingsButton = UIBarButtonItem(image: UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(TagViewController.showSettings))
		
		navigationItem.rightBarButtonItems = [tagSettingsButton]
	}
	
	// 'lazy' = Only occurs once during the execution of the app
	lazy var settingsLauncher: SettingsLauncher = {
		let launcher = SettingsLauncher()
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
		editViewController.navigationItem.title = setting.name
		navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
		navigationController?.navigationBar.tintColor = UIColor.white
		navigationController?.pushViewController(editViewController, animated: true)
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
