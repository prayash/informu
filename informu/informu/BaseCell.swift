//
//  BaseCell.swift
//  informu
//
//  Created by Prayash Thapa on 12/19/16.
//  Copyright © 2016 Prayash Thapa. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	func setupViews() {
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
