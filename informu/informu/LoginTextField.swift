//
//  LoginTextField.swift
//  informu
//
//  Created by Prayash Thapa on 11/12/16.
//  Copyright © 2016 Prayash Thapa. All rights reserved.
//

import UIKit

@IBDesignable
class LoginTextField: UITextField {
	override func layoutSubviews() {
		super.layoutSubviews()
		self.layer.borderColor = UIColor(white: 231 / 255, alpha: 1).cgColor
		self.layer.borderWidth = 1
	}
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: 8, dy: 7)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return textRect(forBounds: bounds)
	}
	/*
	// Only override draw() if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func draw(_ rect: CGRect) {
	// Drawing code
	}
	*/
	
}
