//
//  ToolbarController.swift
//  informu
//
//  Created by Prayash Thapa on 2/18/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit
import Material

class MenuBarController: ToolbarController {
    fileprivate var menuButton: IconButton!
    fileprivate var switchControl: Switch!
    fileprivate var addButton: IconButton!
    
    override func prepare() {
        super.prepare()
        prepareMenuButton()
        prepareSwitch()
        prepareAddButton()
        prepareStatusBar()
        prepareToolbar()
    }
}

extension MenuBarController {
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
        menuButton.tintColor = UIColor(r: 224, g: 116, b: 43)
        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }
    
    fileprivate func prepareSwitch() {
        switchControl = Switch(state: .off, style: .light, size: .small)
    }
    
    fileprivate func prepareAddButton() {
        addButton = IconButton(image: Icon.cm.add)
        addButton.tintColor = UIColor(r: 224, g: 116, b: 43)
        addButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
    }
    
    fileprivate func prepareStatusBar() {
        statusBarStyle = .lightContent
    }
    
    fileprivate func prepareToolbar() {
        toolbar.title = "Home"
        toolbar.titleLabel.font = UIFont(name: "Raleway", size: 20)
        toolbar.leftViews = [menuButton]
        toolbar.rightViews = [addButton]
    }
}

extension MenuBarController {
    @objc
    fileprivate func handleMenuButton() {
        navigationDrawerController?.toggleLeftView()
    }
    
    @objc
    fileprivate func handleAddButton() {
        let addTagController = AddTagController()
        let navController = UINavigationController(rootViewController: addTagController)
        present(navController, animated: true, completion: nil)
    }
}

