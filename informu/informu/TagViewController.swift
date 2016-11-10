//
//  TagViewController.swift
//  informu
//
//  Created by Prayash Thapa on 11/9/16.
//  Copyright © 2016 Prayash Thapa. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {
	@IBOutlet weak var tagImageView: UIImageView!
	
	var image = UIImage()
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tagImageView.image = self.image
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
