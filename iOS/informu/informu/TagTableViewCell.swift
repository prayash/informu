//
//  TagTableViewCell.swift
//  informu
//
//  Created by Prayash Thapa on 12/8/16.
//  Copyright © 2016 Prayash Thapa. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell {
	
	@IBOutlet weak var bgCardView: UIView!
	@IBOutlet weak var tagImageView: UIImageView!
	@IBOutlet weak var tagLabel: UILabel!
	@IBOutlet weak var lastSeenLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		bgCardView.backgroundColor = UIColor.white;
		contentView.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
		bgCardView.layer.cornerRadius = 3.0
		bgCardView.layer.masksToBounds = false
		bgCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
		bgCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
		bgCardView.layer.shadowOpacity = 0.8
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
