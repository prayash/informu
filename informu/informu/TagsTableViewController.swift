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
	let colorArray = [UIColor(red: 0.98, green: 0.58, blue: 0.21, alpha: 1.0), UIColor(red: 0.45, green: 0.44, blue: 0.45, alpha: 1.0)]
	
	@IBAction func menuButtonDidTouch(_ sender: AnyObject) {
			
	}

	@IBAction func addTagButtonDidTouch(_ sender: AnyObject) {
			
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
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
		
		let topBorder = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(414), height: CGFloat(5)))
		topBorder.backgroundColor = self.colorArray[indexPath.row]
//		cell.contentView.addSubview(topBorder)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "MapSegue", sender: self)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
