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
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		appDelegate = UIApplication.shared.delegate as! AppDelegate
		appDelegate.tagsTableViewController = self
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(confirmLogout))
		
		// Disable the ugly default lines
		tableView.separatorStyle = .none
		
		FIRDatabase.database().persistenceEnabled = true
		dbRef = FIRDatabase.database().reference()
		checkIfUserIsLoggedIn()
		
		// Fetch tags if the user is logged in
		if FIRAuth.auth()?.currentUser?.uid != nil {
			fetchTagsFromDatabase()
		}
	}
	
	func checkIfUserIsLoggedIn() {
		if FIRAuth.auth()?.currentUser?.uid == nil {
			performSelector(onMainThread: #selector(logOut), with: nil, waitUntilDone: true)
		} else {
			let uid = FIRAuth.auth()?.currentUser?.uid
			FIRDatabase.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in

			}, withCancel: nil)
		}
	}
	
	func confirmLogout() {
		let logoutAlert = UIAlertController(title: "Log out?", message: "Are you sure you want to log out?", preferredStyle: .alert)
		logoutAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
			self.logOut()
		}))
		
		logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
			return
		}))
		
		present(logoutAlert, animated: true, completion: nil)
	}
	
	func logOut() {
		do {
			try FIRAuth.auth()?.signOut()
		} catch let logoutError {
			print(logoutError)
		}
		
		let loginController = LoginViewController()
		present(loginController, animated: true, completion: nil)
	}
	
	func fetchTagsFromDatabase() {
		print("[ Updating mµ tags from database... ]")
		
		let uid = FIRAuth.auth()?.currentUser?.uid
		FIRDatabase.database().reference().child("Users").child(uid!).observe(.childAdded, with: { (snapshot) in
			
			if let dictionary = snapshot.value as? [String: AnyObject] {
				let tagName = dictionary["name"] as? String
				let tagColor = dictionary["color"] as? String
				let tagProximityUUID = dictionary["proximityUUID"] as? String
				let tagMajor = dictionary["major"] as? String
				let tagMinor = dictionary["minor"] as? String
				let tagLastSeen = dictionary["lastSeen"] as? String
				let tagLocation = dictionary["location"] as? String
				
				self.appDelegate.tags.insert(Tag(name: tagName, color: tagColor, proximityUUID: tagProximityUUID, major: tagMajor, minor: tagMinor, lastSeen: tagLastSeen, location: tagLocation), at: 0)
				print("[ Mµ tags on device:", self.appDelegate.tags)
				
				DispatchQueue.main.async( execute: {
					self.tableView.reloadData()
				})
			}
			
			}, withCancel: nil)
	}
	
	override func viewDidAppear(_ animated: Bool) {
//		checkIfUserIsLoggedIn()
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
		
		// THESE ARE REVERSED
		cell.lastSeenLabel.text = String(format: "Status: %@ ", appDelegate.tags[indexPath.row].location)
		cell.locationLabel.text = String(format: "Last Seen: %@ ", appDelegate.tags[indexPath.row].lastSeen)
		
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
