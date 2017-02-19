//
//  HomeDatasource.swift
//  informu
//
//  Created by Prayash Thapa on 2/18/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import LBTAComponents

class HomeDatasource: Datasource {
    
    let tags: [Tag] = {
        let wallet = Tag(name: "Luggage", color: "mu-orange", proximityUUID: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0", major: "1111", minor: "1111", lastSeen: "Few seconds ago", location: "Nearby")
        
        let passport = Tag(name: "Passport", color: "mu-blue", proximityUUID: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0", major: "1111", minor: "1111", lastSeen: "Few seconds ago", location: "Nearby")
        
        let car = Tag(name: "Car", color: "mu-teal", proximityUUID: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0", major: "1111", minor: "1111", lastSeen: "Few seconds ago", location: "Nearby")
        
        return [wallet, passport, car]
    }()
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [TagCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [TagHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [TagFooter.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return tags[indexPath.item]
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return tags.count
    }
}
