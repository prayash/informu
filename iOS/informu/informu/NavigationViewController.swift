//  NavigationVC.swift
//  informu

import UIKit

// ****************************************************************************************

class NavigationViewController: UINavigationController, UIViewControllerTransitioningDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Status bar white font
		self.navigationBar.barStyle = UIBarStyle.black
		self.navigationBar.tintColor = UIColor.white
		self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 22.0)!];

		// Print out all available fonts
//		for familyName in UIFont.familyNames {
//			for font in UIFont.fontNames(forFamilyName: (familyName as? String)!) {
//				print("font: \(font)")
//			}
//		}
		
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
