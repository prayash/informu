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
	var appDelegate: AppDelegate!
	var users = [User]()
	var availableTags = [Tag]()
	let cellId = "cellId"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		appDelegate = UIApplication.shared.delegate as! AppDelegate
//		appDelegate.addTagController = self
		
		tableView.register(TagCell.self, forCellReuseIdentifier: cellId)
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(handleCancel))
		
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
		
		let availableTag = Tag(name: "mµ tag", color: "mu-orange", proximityUUID: uuidString, major: majorString, minor: minorString, lastSeen: tagLastSeen, location: tagLocation)
		
		for tag in appDelegate.tags {
			if Int(tag.major) == Int(availableTag.major) {
				print("Found an already added tag. Dismissing.")
//				return
			}
		}
		
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
	}
	
	func addTagToDB(tag: Tag) -> Void {
		print("Adding Tag...")
		let tagName = tag.name
		let tagColor = tag.color
		let tagProximityUUID = tag.proximityUUID
		let tagMajor = tag.major
		let tagMinor = tag.minor
		let tagLastSeen = tag.lastSeen
		let tagLocation = tag.location
		
		let tag: [String: Any] = ["name": tagName! as Any,
		                                "color": tagColor! as Any,
		                                "proximityUUID": tagProximityUUID! as Any,
		                                "major": tagMajor! as Any,
		                                "minor": tagMinor! as Any,
		                                "lastSeen": tagLastSeen! as Any,
		                                "location": tagLocation! as Any]
		
		let uid = FIRAuth.auth()?.currentUser?.uid
		FIRDatabase.database().reference().child("Users").child(uid!).child("Tags").setValue(tag) { (err, ref) in
			if err != nil {
				print(err)
				return
			}
			
//			let tagsTableView = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[0] as! TagsTableViewController
//			DispatchQueue.main.async(execute: {
//				tagsTableView.tableView.reloadData()
//			})
			
			// Tag successfully added to db
			self.dismiss(animated: true, completion: nil)
		}
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return availableTags.count
//		return users.count
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
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedTag = availableTags[indexPath.row]
		for tag in appDelegate.tags {
			if Int(selectedTag.major) == Int(tag.major) {
				print("This tag has already been added!")
				
				let alertController = UIAlertController(title: "Tag already added!", message: "This tag is already linked to your device.", preferredStyle: .alert)
				let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
				alertController.addAction(defaultAction)
				
				present(alertController, animated: true, completion: nil)
				return
			} else {
				addTagToDB(tag: selectedTag);
				
				dismiss(animated: true, completion: nil)
				tableView.deselectRow(at: indexPath, animated: true)
				return
			}
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
}

class TagCell: UITableViewCell {
	
	override func layoutSubviews() {
		super.layoutSubviews()
		textLabel?.frame = CGRect(x: 56, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
		detailTextLabel?.frame = CGRect(x: 56, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
	}
	
	let tagImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = nil
		imageView.contentMode = .scaleAspectFit
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
