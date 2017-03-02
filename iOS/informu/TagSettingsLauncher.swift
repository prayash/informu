//
//  TagSettings.swift
//  informu
//
//  Created by Prayash Thapa on 2/19/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

class TagSettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    var tagViewController: TagViewController?
    let overlayView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    let settings: [Setting] = {
        let cancelSetting = Setting(name: .Cancel, imageName: "cancel")
        return [Setting(name: .Settings, imageName: "settings"),
                Setting(name: .Remove, imageName: "remove"),
                cancelSetting]
    }()
    
    func showSettings() {
        
        if let window = UIApplication.shared.keyWindow  {
            overlayView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(overlayView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let yPos = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 200)
            
            overlayView.frame = window.frame
            overlayView.alpha = 0
            
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.overlayView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: yPos, width: self.collectionView.frame.width, height: self.collectionView.frame.width)
                }, completion: nil)
            
        }
    }
    
    func handleDismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.overlayView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow  {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed: Bool) in
            
            // Dismiss menu if tapped on overlayView
            if setting.name.rawValue.isEmpty || setting.name == .Cancel {
                return
            } else if setting.name == .Settings {
//                self.tagViewController?.showEditViewController(setting: setting)
                self.createLocationNotification(msg: "You have left your passport behind!")
            } else if setting.name == .Remove {
                self.createLocationNotification(msg: "Your calendar shows you have a flight today at 4:30 PM. Don't forget to take your passport and luggage.")
                print("Deleting...")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleDismiss(setting: self.settings[indexPath.item])
    }
    
    func createLocationNotification(msg: String) {
        // Fire off LocalNotification now.
        let localNotification = UILocalNotification()
        localNotification.fireDate = Date().addingTimeInterval(30)
        localNotification.applicationIconBadgeNumber = 0
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.alertBody = msg
        
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}

