//
//  HomeController.swift
//  informu
//
//  Created by Prayash Thapa on 2/18/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit
import Material
import CoreLocation
import LBTAComponents
import UserNotifications

let imageArray = [UIImage(named: "mu-orange"),
                  UIImage(named: "mu-teal"),
                  UIImage(named: "mu-blue")]

let muOrange = UIColor(r: 224, g: 116, b: 43)

class HomeController: DatasourceController, ManagerDelegate {
    
    fileprivate var menuButton: IconButton!
    fileprivate var addButton: IconButton!
    var homeDatasource: HomeDatasource!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        Manager.sharedInstance.delegate = self
        
        view.backgroundColor = UIColor(r: 130, g: 130, b: 130)
        
        prepareAddButton()
        prepareMenuButton()
        prepareNavigationItems()
        
        homeDatasource = HomeDatasource()
        self.datasource = homeDatasource
        collectionView?.delaysContentTouches = false
        
        Manager.sharedInstance.fetchTagsFromDatabase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    func didExitRegion(region: CLRegion) {
        print("didExitRegion")
    }
    
    func didUpdateDistance(proximity: CLProximity) {
        switch proximity {
        case .unknown:
            if homeDatasource.tags[0].name != "Car" && homeDatasource.tags[0].name != "Passport" {
                homeDatasource.tags[0].location = "Lost"
                homeDatasource.tags[0].lastSeen = "A minute ago"
                collectionView?.reloadData()
                print("out of range")
            }
//            let localNotification = UILocalNotification()
//            localNotification.fireDate = Date()
//            localNotification.applicationIconBadgeNumber = 0
//            localNotification.soundName = UILocalNotificationDefaultSoundName
//            localNotification.alertBody = "You have gone out of range with the mµ tag"
//            UIApplication.shared.scheduleLocalNotification(localNotification)
            
        case .far:
            if homeDatasource.tags[0].name != "Car" && homeDatasource.tags[0].name != "Passport" {
                homeDatasource.tags[0].location = "Farther away"
                homeDatasource.tags[0].lastSeen = "Few seconds ago"
                collectionView?.reloadData()
                print("farther away")
            }
            
            
        case .near:
            if homeDatasource.tags[0].name != "Car" && homeDatasource.tags[0].name != "Passport" {
                homeDatasource.tags[0].location = "Nearby"
                homeDatasource.tags[0].lastSeen = "Few seconds ago"
                collectionView?.reloadData()
                print("nearby")
            }
            
        case .immediate:
            if homeDatasource.tags[0].name != "Car" && homeDatasource.tags[0].name != "Passport" {
                homeDatasource.tags[0].location = "Immediate"
                homeDatasource.tags[0].lastSeen = "Few seconds ago"
                collectionView?.reloadData()
                print("immediate")
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tag = self.datasource?.item(indexPath) as? Tag else { return }
        
        let tagViewController = TagViewController(tag: tag)
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
