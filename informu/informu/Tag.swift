//
//  Tag.swift
//  informu
//
//  Created by Prayash Thapa on 12/19/16.
//  Copyright © 2016 Prayash Thapa. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Tag {
	let name: String!
	let color: String!
	let proximityUUID: String!
	let major: String!
	let minor: String!
	var lastSeen: String!
	var location: String!
	let tagId: String!
	
//	init (name: String, color: String, proximityUUID: String, major: String, minor: String, lastSeen: String, location: String) {
//		self.name = name
//		self.color = color
//		self.proximityUUID = proximityUUID
//		self.major = major
//		self.minor = minor
//		self.lastSeen = lastSeen
//		self.location = location
//		self.itemRef = nil
//	}
//	
//	init (snapshot: FIRDataSnapshot) {
//		self.itemRef = snapshot.ref
//		if let sName = snapshot.value!["name"] as? String {
//			name = sName
//		} else {
//			name = ""
//		}
//	}
//	
//	func toAnyObject() -> AnyObject {
//		return ["name": name]
//	}
}
