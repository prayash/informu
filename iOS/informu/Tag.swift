//
//  Tag.swift
//  informu
//
//  Created by Prayash Thapa on 2/18/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

class Tag {
    let name: String
    let color: String
    let proximityUUID: String
    let major: String
    let minor: String
    var lastSeen: String
    var location: String
    
    init(name: String, color: String, proximityUUID: String, major: String, minor: String, lastSeen: String, location: String) {
        self.name = name
        self.color = color
        self.proximityUUID = proximityUUID
        self.major = major
        self.minor = minor
        self.lastSeen = lastSeen
        self.location = location
    }
}

