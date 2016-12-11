//
//  TagsTableViewController.swift
//  informu
//
//  Created by Prayash Thapa on 12/8/16.
//  Copyright © 2016 Prayash Thapa. All rights reserved.
//

import UIKit

class TagsTableViewController: UITableViewController {
	let tags = ["Wallet", "MacBook"]
	let imageArray = [UIImage(named: "mu1"), UIImage(named: "mu2")]
	let colorArray = [UIColor(red: 224/255.0, green: 116/255.0, blue: 43/255.0, alpha: 1.0), UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1.0)]
	
	@IBAction func menuButtonDidTouch(_ sender: AnyObject) {
			
	}

	@IBAction func addTagButtonDidTouch(_ sender: AnyObject) {
			
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Disable the ugly default lines
		tableView.separatorStyle = .none
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		// self.tableView.bounds = CGRect(x: 0, y: 40, width: 320, height: 600)
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
		return 2
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell") as! TagTableViewCell
		cell.tagLabel.text = self.tags[indexPath.row]
		cell.tagImageView.image = self.imageArray[indexPath.row]
		cell.tagLabel.textColor = self.colorArray[indexPath.row]
		cell.lastSeenLabel.text = "Last Seen: Today at 4:58 PM"
		cell.locationLabel.text = "Location: 1023 Walnut St."
		
		// Top border for each Cell
		let topBorder = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(355), height: CGFloat(5)))
		topBorder.backgroundColor = self.colorArray[indexPath.row].withAlphaComponent(0.5)
		cell.bgCardView.addSubview(topBorder)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "MapSegue", sender: self)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
