//
//  TagCell.swift
//  informu
//
//  Created by Prayash Thapa on 2/18/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit
import LBTAComponents

var imageArr: [String: UIImage] = ["mu-orange": UIImage(named: "mu-orange")!,
                                   "mu-teal": UIImage(named: "mu-teal")!,
                                   "mu-blue": UIImage(named: "mu-blue")!]

var colors: [String: UIColor] = ["mu-orange": UIColor(r: 224, g: 116, b: 43),
                                 "mu-teal": UIColor(r: 66, g: 66, b: 66),
                                 "mu-blue": UIColor(r: 101, g: 216, b: 216)]

class TagCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let tag = datasourceItem as? Tag else { return }
            
            nameLabel.text = datasourceItem as? String
            nameLabel.text = tag.name
            tagPicture.image = imageArr[tag.color]
            statusLabel.text = String(format: "Status: %@ ", tag.location)
            lastSeenLabel.text = String(format: "Last Seen: %@ ", tag.lastSeen)
            topBorder.backgroundColor = colors[tag.color]
        }
    }
    
    let tagPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "mu-orange")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Prayash Thapa"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        let string = "Nearby"
        label.text = "Placeholder"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        return label
        
    }()
    
    let lastSeenLabel: UILabel = {
        let label = UILabel()
        label.text = "Placeholder"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        return label
    }()
    
    let disclosureIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "disclosure_indicator")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let topBorder: UIView = {
        let border = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(400), height: CGFloat(3)))
        border.backgroundColor = UIColor(red: 224/255.0, green: 116/255.0, blue: 43/255.0, alpha: 1.0)
        return border
    }()
    
    
    override func setupViews() {
        super.setupViews()
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
//        layer.borderColor = UIColor.blue.cgColor
//        layer.borderWidth = 1
        
        backgroundColor = .white
        
        addSubview(topBorder)
        addSubview(tagPicture)
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(lastSeenLabel)
        addSubview(disclosureIndicator)
        
        tagPicture.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        
        nameLabel.anchor(tagPicture.topAnchor, left: tagPicture.rightAnchor, bottom: nil, right: disclosureIndicator.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        statusLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        lastSeenLabel.anchor(statusLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        disclosureIndicator.anchor(topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 42, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 15, heightConstant: 15)
    }
}


