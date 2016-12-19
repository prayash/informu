//
//  SettingCell.swift
//  informu
//
//  Created by Prayash Thapa on 12/19/16.
//  Copyright © 2016 Prayash Thapa. All rights reserved.
//

import UIKit

class Setting: NSObject {
	let name: SettingName
	let imageName: String
	
	init(name: SettingName, imageName: String) {
		self.name = name
		self.imageName = imageName
	}
}

enum SettingName: String {
	case Cancel = "Cancel"
	case Settings = "Settings"
	case Remove = "Remove"
}

class SettingCell: BaseCell {
	
	override var isHighlighted: Bool {
		didSet {
			backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
			nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
			iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
		}
	}
	
	var setting: Setting? {
		didSet {
			nameLabel.text = setting?.name.rawValue
			
			if let imageName = setting?.imageName {
				iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
				iconImageView.tintColor = UIColor.darkGray
			}
		}
	}
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.text = "Setting"
		label.font = UIFont.systemFont(ofSize: 13)
		return label
	}()
	
	let iconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "settings")
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	override func setupViews() {
		super.setupViews()
		
		addSubview(nameLabel)
		addSubview(iconImageView)
		
		addConstraintsWithFormat("H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
		addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
		addConstraintsWithFormat("V:[v0(30)]", views: iconImageView)
		addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
	}
	
}
