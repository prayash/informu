//  TagsTableViewController.swift
//  informu
//
//  Created by Prayash Thapa on 12/8/16.
//  Copyright © 2016 Prayash Thapa. All rights reserved.

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TagsTableViewController: UITableViewController {
	var dbRef: FIRDatabaseReference!
	var appDelegate: AppDelegate!
	
	let MAX_TAGS = 2
	var currentTags = 0
	
	let imageArray = [UIImage(named: "mu-orange"),
	                  UIImage(named: "mu-teal"),
	                  UIImage(named: "mu-blue")]
	
	var colors: [String: UIColor] = ["mu-orange": UIColor(red: 224/255.0, green: 116/255.0, blue: 43/255.0, alpha: 1.0),
	                                   "mu-teal": UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1.0),
	                                   "mu-blue": UIColor(red: 101/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1.0)]
	
	@IBOutlet weak var headerTextAboveTable: UILabel!
	@IBAction func menuButtonDidTouch(_ sender: AnyObject) {
		print("Slide out Menu")
	}

	@IBAction func addTagButtonDidTouch(_ sender: AnyObject) {
		let addTagController = AddTagController()
		let navController = UINavigationController(rootViewController: addTagController)
		
		present(navController, animated: true, completion: nil)
		
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
		appDelegate = UIApplication.shared.delegate as! AppDelegate
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
		
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
			
			self.appDelegate.tags.insert(Tag(name: tagName, color: tagColor, proximityUUID: tagProximityUUID, major: tagMajor, minor: tagMinor, lastSeen: tagLastSeen, location: tagLocation), at: 0)
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
			
			self.appDelegate.tags.remove(at: Int(tagColor!)!)
			self.tableView.reloadData()
		})
	}
	
	func checkIfUserIsLoggedIn() {
		if FIRAuth.auth()?.currentUser?.uid == nil {
			performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: true)
		} else {
			let uid = FIRAuth.auth()?.currentUser?.uid
			FIRDatabase.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
				
				if let dictionary = snapshot.value as? [String: AnyObject] {
					let nameString = dictionary["name"] as? String
						self.headerTextAboveTable.text = "TAGS (" + nameString! + ")"
				}
				
				}, withCancel: nil)
		}
	}
	
	func handleLogout() {
		
		do {
			try FIRAuth.auth()?.signOut()
		} catch let logoutError {
			print(logoutError)
		}
		
		let loginController = LoginViewController()
		present(loginController, animated: true, completion: nil)
	}
	
	override func viewDidAppear(_ animated: Bool) {

		checkIfUserIsLoggedIn()
		
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
		return appDelegate.tags.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell") as! TagTableViewCell
		cell.tagLabel.text = appDelegate.tags[indexPath.row].name
		cell.tagImageView.image = UIImage(named: String(appDelegate.tags[indexPath.row].color))
		cell.tagLabel.textColor = colors[String(appDelegate.tags[indexPath.row].color)!]
		cell.lastSeenLabel.text = String(format: "Last Seen: %@ ", appDelegate.tags[indexPath.row].lastSeen)
		cell.locationLabel.text = String(format: "Location: %@ ", appDelegate.tags[indexPath.row].location)
		
		// Top border for each Cell
		let topBorder = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(355), height: CGFloat(5)))
		topBorder.backgroundColor = colors[String(appDelegate.tags[indexPath.row].color)]?.withAlphaComponent(1)
		cell.bgCardView.addSubview(topBorder)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "MapSegue", sender: self)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
