//
//  TagsTableViewController.swift
//  informu
//
//  Created by Prayash Thapa on 12/8/16.
//  Copyright © 2016 Prayash Thapa. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TagsTableViewController: UITableViewController {
	var tags = [Tag]()
	let imageArray = [UIImage(named: "mu-orange"),
	                  UIImage(named: "mu-teal"),
	                  UIImage(named: "mu-blue")]
	
	let INF_ORANGE = UIColor(red: 224/255.0, green: 116/255.0, blue: 43/255.0, alpha: 1.0)
	let INF_TEAL = UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1.0)
	let INF_BLUE = UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1.0)
	
	var colorArray = [UIColor]()
	
	@IBAction func menuButtonDidTouch(_ sender: AnyObject) {
		
	}

	@IBAction func addTagButtonDidTouch(_ sender: AnyObject) {
		addTag(color: 0)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Disable the ugly default lines
		tableView.separatorStyle = .none
		
		// Add color palette
		colorArray = [INF_ORANGE, INF_TEAL, INF_BLUE]
		
		FIRDatabase.database().persistenceEnabled = true
		let dbRef = FIRDatabase.database().reference()
		dbRef.child("Tags").queryOrderedByKey().observe(.childAdded, with: {
			snapshot in
			
			guard let snapshotDict = snapshot.value as? [String: String] else {
				// Do something to handle the error
				// if your snapshot.value isn't the type you thought it was going to be.
				return;
			}

			let tagName = snapshotDict["name"]
			let tagColor = snapshotDict["color"]
			let tagProximityUUID = snapshotDict["proximityUUID"]
			let tagLastSeen = snapshotDict["lastSeen"]
			let tagLocation = snapshotDict["location"]
			
			self.tags.insert(Tag(name: tagName, color: tagColor, proximityUUID: tagProximityUUID, lastSeen: tagLastSeen, location: tagLocation), at: 0)
			self.tableView.reloadData()
		})
		
		dbRef.child("Tags").queryOrderedByKey().observe(.childRemoved, with: {
			snapshot in
			
			guard let snapshotDict = snapshot.value as? [String: String] else {
				// Do something to handle the error
				// if your snapshot.value isn't the type you thought it was going to be.
				return;
			}
			
//			let tagName = snapshotDict["name"]
			let tagColor = snapshotDict["color"]
//			let tagProximityUUID = snapshotDict["proximityUUID"]
//			let tagLastSeen = snapshotDict["lastSeen"]
//			let tagLocation = snapshotDict["location"]
			
			self.tags.remove(at: Int(tagColor!)!)
			self.tableView.reloadData()
		})
	}
	
	override func viewDidAppear(_ animated: Bool) {
		// self.tableView.bounds = CGRect(x: 0, y: 40, width: 320, height: 600)
	}
	
	func addTag(color: Int) -> Void {
		let tagName = "Wallet"
		let tagColor = "1"
		let tagProximityUUID = "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"
		let tagLastSeen = "Today at 11:16 PM"
		let tagLocation = "1311 College Ave"
		
		let tag: [String: AnyObject] = ["name": tagName as AnyObject,
																		"color": tagColor as AnyObject,
																		"proximityUUID": tagProximityUUID as AnyObject,
																		"lastSeen": tagLastSeen as AnyObject,
																		"location": tagLocation as AnyObject]
		
		let dbRef = FIRDatabase.database().reference()
		dbRef.child("Tags").childByAutoId().setValue(tag)
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
		// Initial state of cell (full transparency)
		cell.alpha = 0
		
		// Transform animation that brings em up
		let entryAnim = CATransform3DTranslate(CATransform3DIdentity, 0, 500, 0)
		cell.layer.transform = entryAnim
		
		// Animate in the tag Cells
		UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.15, options: [], animations: {
			cell.alpha = 1.0
			cell.layer.transform = CATransform3DIdentity
		})
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tags.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell") as! TagTableViewCell
		cell.tagLabel.text = tags[indexPath.row].name
		cell.tagImageView.image = imageArray[Int(tags[indexPath.row].color)!]
		cell.tagLabel.textColor = colorArray[Int(tags[indexPath.row].color)!]
		cell.lastSeenLabel.text = tags[indexPath.row].lastSeen
		cell.locationLabel.text = tags[indexPath.row].location
		
		// Top border for each Cell
		let topBorder = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(355), height: CGFloat(5)))
		topBorder.backgroundColor = colorArray[indexPath.row].withAlphaComponent(0.5)
		cell.bgCardView.addSubview(topBorder)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "MapSegue", sender: self)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
