//  TagsTableViewController.swift
//  informu
//
//  Created by Prayash Thapa on 12/8/16.
//  Copyright © 2016 Prayash Thapa. All rights reserved.

import UIKit
import FirebaseDatabase

class TagsTableViewController: UITableViewController {
	var tags = [Tag]()
	var dbRef: FIRDatabaseReference!
	
	let MAX_TAGS = 2
	var currentTags = 0
	
	let imageArray = [UIImage(named: "mu-orange"),
	                  UIImage(named: "mu-teal"),
	                  UIImage(named: "mu-blue")]
	
	var colors: [String: UIColor] = ["mu-orange": UIColor(red: 224/255.0, green: 116/255.0, blue: 43/255.0, alpha: 1.0),
	                                   "mu-teal": UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1.0),
	                                   "mu-blue": UIColor(red: 101/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1.0)]
	
	@IBAction func menuButtonDidTouch(_ sender: AnyObject) {
		print("Slide out Menu")
	}

	@IBAction func addTagButtonDidTouch(_ sender: AnyObject) {
		if (currentTags <= 2) {
			// addTagToDB(name: "Wallet", color: "mu-orange")
		}
		
//		let tagAlert = UIAlertController(title: "New Tag", message: "Enter your tag", preferredStyle: .alert)
//		tagAlert.addTextField { (textField: UITextField) in
//			textField.placeholder = "Your tag name"
//		}
//		
//		tagAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action: UIAlertAction) in
//			if let tagName = tagAlert.textFields?.first?.text {
//				let tag = Tag()
//				let tagRef = self.dbRef.child("Tags")
//				tagRef.setValue()
//			}
//		}))
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		appDelegate.tagsTableViewController = self
		
		// Disable the ugly default lines
		tableView.separatorStyle = .none
		
		FIRDatabase.database().persistenceEnabled = true
		dbRef = FIRDatabase.database().reference()
		
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
			let tagMajor = snapshotDict["major"]
			let tagMinor = snapshotDict["minor"]
			let tagLastSeen = snapshotDict["lastSeen"]
			let tagLocation = snapshotDict["location"]
			let tagId = snapshotDict["tagId"]
			
			self.tags.insert(Tag(name: tagName, color: tagColor, proximityUUID: tagProximityUUID, major: tagMajor, minor: tagMinor, lastSeen: tagLastSeen, location: tagLocation, tagId: tagId), at: 0)
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
//		dbRef.child("Tags").observeSingleEvent(of: .value, with: {
//			snapshot in
//			
//			let value = snapshot.value as? NSDictionary
//			let tagName = value?["name"] as? String ?? ""
//			print(tagName)
//			
//			guard let snapshotDict = snapshot.value as? [String: String] else {
//				// Do something to handle the error
//				// if your snapshot.value isn't the type you thought it was going to be.
//				return;
//			}
//			
//			//			let tagName = snapshotDict["name"]
//			let tagColor = snapshotDict["color"]
//			let tagProximityUUID = snapshotDict["proximityUUID"]
//			let tagMajor = snapshotDict["major"]
//			let tagMinor = snapshotDict["minor"]
//			let tagLastSeen = snapshotDict["lastSeen"]
//			let tagLocation = snapshotDict["location"]
//			let tagId = snapshotDict["tagId"]
//			
//			self.tags.insert(Tag(name: tagName, color: tagColor, proximityUUID: tagProximityUUID, major: tagMajor, minor: tagMinor, lastSeen: tagLastSeen, location: tagLocation, tagId: tagId), at: 0)
//			self.tableView.reloadData()
//			
//		})
	}
	
	func addTagToDB(name: String, color: String, proximityUUID: String, major: String, minor: String) -> Void {
		print("Adding Tag...")
		let tagName = name
		let tagColor = color
		let tagProximityUUID = "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"
		let tagMajor = major
		let tagMinor = minor
		let tagLastSeen = "Just Now"
		let tagLocation = "Searching..."
		
		let tag: [String: AnyObject] = ["name": tagName as AnyObject,
																		"color": tagColor as AnyObject,
																		"proximityUUID": tagProximityUUID as AnyObject,
																		"major": tagMajor as AnyObject,
																		"minor": tagMinor as AnyObject,
																		"lastSeen": tagLastSeen as AnyObject,
																		"location": tagLocation as AnyObject]
		
		let dbRef = FIRDatabase.database().reference()
		let tagRef = dbRef.child("Tags").childByAutoId()
		tagRef.setValue(tag)
		let tagId = tagRef.key
		print(tagId)
		dbRef.child("Tags").child(tagId).child("tagId").setValue(tagId)
		
		tags.insert(Tag(name: tagName, color: tagColor, proximityUUID: tagProximityUUID, major: tagMajor, minor: tagMinor, lastSeen: tagLastSeen, location: tagLocation, tagId: tagId), at: 0)
		currentTags += 1;
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
//		// Initial state of cell (full transparency)
//		cell.alpha = 0
//		
//		// Transform animation that brings em up
//		let entryAnim = CATransform3DTranslate(CATransform3DIdentity, 0, 500, 0)
//		cell.layer.transform = entryAnim
//		
//		// Animate in the tag Cells
//		UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.15, options: [], animations: {
//			cell.alpha = 1.0
//			cell.layer.transform = CATransform3DIdentity
//		})
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tags.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell") as! TagTableViewCell
		cell.tagLabel.text = tags[indexPath.row].name
		cell.tagImageView.image = UIImage(named: String(tags[indexPath.row].color))
		cell.tagLabel.textColor = colors[String(tags[indexPath.row].color)!]
		cell.lastSeenLabel.text = String(format: "Last Seen: %@ ", tags[indexPath.row].lastSeen)
		cell.locationLabel.text = String(format: "Location: %@ ", tags[indexPath.row].location)
		
		// Top border for each Cell
		let topBorder = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(355), height: CGFloat(5)))
		topBorder.backgroundColor = colors[String(tags[indexPath.row].color)]?.withAlphaComponent(1)
		cell.bgCardView.addSubview(topBorder)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "MapSegue", sender: self)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
