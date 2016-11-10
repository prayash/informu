// informu
// TagViewController.swift
// This View shows details of the µ tag. It displays information about the specific tag.
// It also shows the user's current location and the tag's location.

import UIKit
import MapKit

class TagViewController: UIViewController {
	@IBOutlet weak var tagImageView: UIImageView!
	@IBOutlet weak var mapView: MKMapView!
	
	var image = UIImage()
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tagImageView.image = self.image
		
		// Show user location + zoom in
		mapView.showsUserLocation = true
		self.mapView.setUserTrackingMode(.follow, animated: true);
		let userLocation = mapView.userLocation
		print(userLocation)
		
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
