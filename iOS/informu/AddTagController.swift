//
//  AddTagController.swift
//  informu
//
//  Created by Prayash Thapa on 2/18/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit

class AddTagController: UITableViewController {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add a Tag"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = muOrange
        
        tableView.register(AddTagCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AddTagCell
        
        // Display all found tags
        let tag = Tag(name: "mu-tag", color: "mu-orange", proximityUUID: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0", major: "1111", minor: "1111", lastSeen: "Few seconds ago", location: "Nearby")
        cell.textLabel?.text = tag.name
        cell.detailTextLabel?.text = tag.proximityUUID
        cell.tagImageView.image = UIImage(named: tag.color)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert()
        tableView.deselectRow(at: indexPath, animated: true)
        return
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Name your tag.", message: "What will you be attaching it to?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: configurationTextField)
        
        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
            print("User added tag.")
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: {
            print("Popped up add tag alert.")
        })
    }
    
    func configurationTextField(textField: UITextField!){
        textField.text = ""
    }
}

