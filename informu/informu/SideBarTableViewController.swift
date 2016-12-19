//  SideBarTableViewController.swift
//  Created by Prayash Thapa on 12/19/16.


import UIKit

protocol SideBarTableViewDelegate {
	func sideBarControlDidSelectRow(indexPath: NSIndexPath)
}

class SideBarTableViewController: UITableViewController {
	
	var delegate : SideBarTableViewDelegate?
	var tableData:Array<String> = []
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 0
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableData.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "MenuCell")!
		
		if (cell == nil) {
			cell = UITableViewCell(style: .default, reuseIdentifier: "MenuCell")
			cell!.backgroundColor = UIColor.clear
			cell!.textLabel?.textColor = UIColor.darkText
		}
		
		cell?.textLabel?.text = tableData[indexPath.row]
		
		return cell!
	}
}
