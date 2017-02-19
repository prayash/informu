//
//  MenuController.swift
//  informu
//
//  Created by Prayash Thapa on 2/18/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit
import Material

class MenuController: UIViewController {
    fileprivate var transitionButton: FlatButton!
    fileprivate var menuLogo: UIImageView!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
            view.backgroundColor = Color.orange.base
//        view.backgroundColor = UIColor(r: 224, g: 116, b: 43)
        
        prepareMenuButtons()
    }
}

extension MenuController {
    fileprivate func prepareMenuButtons() {
        transitionButton = FlatButton(title: "Log Out", titleColor: .white)
        transitionButton.titleLabel?.font = UIFont(name: "Raleway", size: 24)
        transitionButton.pulseColor = .white
        transitionButton.addTarget(self, action: #selector(handleTransitionButton), for: .touchUpInside)
        view.layout(transitionButton).bottomLeft(bottom: 12, left: 12)
    }
    
    fileprivate func prepareMenuLogo() {
        menuLogo = UIImageView()
//        menuLogo.image =
    }
}

extension MenuController {
    @objc
    fileprivate func handleTransitionButton() {
        // Transition the entire NavigationDrawer rootViewController.
        //        navigationDrawerController?.transition(to: TransitionedViewController(), completion: closeNavigationDrawer)
        
        // Transition the ToolbarController rootViewController that is in the NavigationDrawer rootViewController.
//        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: LoginController(), completion: closeNavigationDrawer)
    
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
        navigationDrawerController?.closeLeftView()
    }
    
    fileprivate func closeNavigationDrawer(result: Bool) {
        navigationDrawerController?.closeLeftView()
    }
}

