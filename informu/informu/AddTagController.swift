//
//  AddTagController.swift
//  informu
//
//  Created by Prayash Thapa on 12/20/16.
//  Copyright © 2016 Prayash Thapa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CoreLocation

class User: NSObject {
	var name: String?
	var email: String?
}

class AddTagController: UITableViewController {
	var appDelegate = UIApplication.shared.delegate as! AppDelegate
	var users = [User]()
	var availableTags = [Tag]()
	let cellId = "cellId"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(TagCell.self, forCellReuseIdentifier: cellId)
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(handleCancel))
		
		fetchTags()
		appDelegate.startScanning()
	}
	
	func handleCancel() {
		dismiss(animated: true, completion: nil)
	}
	
	func showAvailableTags(beacon: CLBeacon) {
		// print(beacon)
		let uuidString = beacon.proximityUUID.uuidString
		let majorString = beacon.major.stringValue
		let minorString = beacon.minor.stringValue
		let tagLastSeen = "Just Now"
		let tagLocation = appDelegate.parseProximity(distance: beacon.proximity)
		
		let availableTag = Tag(name: "mµ tag", color: "mu-teal", proximityUUID: uuidString, major: majorString, minor: minorString, lastSeen: tagLastSeen, location: tagLocation)
		
		if (availableTags.isEmpty) {
			self.availableTags.append(availableTag)
		} else {
			for tag in availableTags {
				if Int(tag.major) == Int(availableTag.major)  {
					
				} else {
					self.availableTags.append(availableTag)
				}
			}
		}
		
		print("* * * * * * * * * * * * * * * * * * * * ")
		print("- ", self.availableTags.count, " mµ tag found! -")
		print("Available tags: ", self.availableTags)
		
		DispatchQueue.main.async(execute: {
			self.tableView.reloadData()
		})
		
		print("* * * * * * * * * * * * * * * * * * * * ")
	}
	
	func fetchTags() {
		FIRDatabase.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
			print("User Found")
//			print(snapshot)
			
			if let dictionary = snapshot.value as? [String: AnyObject] {
				let user = User()
				
				// If we use this setter, app will crash if the class properties don't exactly match with Firebase dictionary keys
				user.setValuesForKeys(dictionary)
				self.users.append(user)
				
				// This will crash due to background thread, use DispatchQueue.main.async to fix
				DispatchQueue.main.async( execute: {
					self.tableView.reloadData()
				})
				
				// user.name = dictionary["name"]

				print(user.name, user.email)
			}
			
			}, withCancel: nil)
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
		
		let uid = FIRAuth.auth()?.currentUser?.uid
		FIRDatabase.database().reference().child("Users").child(uid!).child("Tags").setValue(tag)
		
		appDelegate.tags.insert(Tag(name: tagName, color: tagColor, proximityUUID: tagProximityUUID, major: tagMajor, minor: tagMinor, lastSeen: tagLastSeen, location: tagLocation), at: 0)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return availableTags.count
		return users.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TagCell
		
		// Display all found tags
		if (availableTags.count > 0) {
			let tag = availableTags[indexPath.row]
			cell.textLabel?.text = tag.name
			cell.detailTextLabel?.text = tag.proximityUUID
			cell.tagImageView.image = UIImage(named: tag.color)
		}
		
		// Displays all users on db
//		let user = users[indexPath.row]
//		cell.textLabel?.text = user.name
//		cell.detailTextLabel?.text = user.email
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
}

class TagCell: UITableViewCell {
	
	override func layoutSubviews() {
		super.layoutSubviews()
		textLabel?.frame = CGRect(x: 56, y: textLabel!.frame.origin.y, width: textLabel!.frame.width, height: textLabel!.frame.height)
		detailTextLabel?.frame = CGRect(x: 56, y: detailTextLabel!.frame.origin.y, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
	}
	
	let tagImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = nil
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
		addSubview(tagImageView)
		
		tagImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
		tagImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		tagImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
		tagImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
