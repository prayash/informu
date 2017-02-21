//
//  HomeController.swift
//  informu
//
//  Created by Prayash Thapa on 2/18/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit
import Material
import LBTAComponents

let imageArray = [UIImage(named: "mu-orange"),
                  UIImage(named: "mu-teal"),
                  UIImage(named: "mu-blue")]

let muOrange = UIColor(r: 224, g: 116, b: 43)

class HomeController: DatasourceController {
    fileprivate var menuButton: IconButton!
    fileprivate var addButton: IconButton!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 130, g: 130, b: 130)
        
        prepareAddButton()
        prepareMenuButton()
        prepareNavigationItems()
        
        let homeDatasource = HomeDatasource()
        self.datasource = homeDatasource
        collectionView?.delaysContentTouches = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tagViewController = TagViewController()
        tagViewController.tag = self.datasource?.item(indexPath) as? Tag
        navigationController?.pushViewController(tagViewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor(r: 200, g: 200, b: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white
    }
}

extension HomeController {
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
        menuButton.tintColor = muOrange
        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }
    
    fileprivate func prepareAddButton() {
        addButton = IconButton(image: Icon.cm.add)
        addButton.tintColor = muOrange
        addButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
    }
    
    fileprivate func prepareNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.titleLabel.font = UIFont(name: "Raleway", size: 20)
        navigationItem.leftViews = [menuButton]
        navigationItem.rightViews = [addButton]
//        navigationController?.setToolbarHidden(true, animated: true)
    }
    
}

extension HomeController {
    @objc
    fileprivate func handleAddButton() {
        let addTagController = AddTagController()
        let navController = UINavigationController(rootViewController: addTagController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc
    fileprivate func handleMenuButton() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
//        let navController = UINavigationController(rootViewController: loginController)
//        present(navController, animated: true, completion: nil)
    }
}
