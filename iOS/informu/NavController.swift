//
//  NavigationController.swift
//  informu
//
//  Created by Prayash Thapa on 2/18/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit
import Material

class NavController: NavigationController {
    open override func prepare() {
        super.prepare()
        guard let v = navigationBar as? NavigationBar else {
            return
        }
        
        v.depthPreset = .none
        v.dividerColor = Color.grey.lighten3
        Application.statusBarStyle = .default
    }
}

//class NavController: NavigationDrawerController {
//    open override func prepare() {
//        super.prepare()
//        
//        delegate = self
//        Application.statusBarStyle = .default
//    }
//}
//
//extension NavController: NavigationDrawerControllerDelegate {
//    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, willOpen position: NavigationDrawerPosition) {
//        print("navigationDrawerController willOpen")
//    }
//    
//    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, didOpen position: NavigationDrawerPosition) {
//        print("navigationDrawerController didOpen")
//    }
//    
//    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, willClose position: NavigationDrawerPosition) {
//        print("navigationDrawerController willClose")
//    }
//    
//    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, didClose position: NavigationDrawerPosition) {
//        print("navigationDrawerController didClose")
//    }
//    
//    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, didBeginPanAt point: CGPoint, position: NavigationDrawerPosition) {
//        print("navigationDrawerController didBeginPanAt: ", point, "with position:", .left == position ? "Left" : "Right")
//    }
//    
//    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, didChangePanAt point: CGPoint, position: NavigationDrawerPosition) {
//        print("navigationDrawerController didChangePanAt: ", point, "with position:", .left == position ? "Left" : "Right")
//    }
//    
//    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, didEndPanAt point: CGPoint, position: NavigationDrawerPosition) {
//        print("navigationDrawerController didEndPanAt: ", point, "with position:", .left == position ? "Left" : "Right")
//    }
//    
//    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, didTapAt point: CGPoint, position: NavigationDrawerPosition) {
//        print("navigationDrawerController didTapAt: ", point, "with position:", .left == position ? "Left" : "Right")
//    }
//    
//    func navigationDrawerController(navigationDrawerController: NavigationDrawerController, statusBar isHidden: Bool) {
//        //print("navigationDrawerController statusBar is hidden:", isHidden ? "Yes" : "No")
//    }
//}

