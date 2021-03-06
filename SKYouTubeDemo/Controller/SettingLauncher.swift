//
//  SettingLauncher.swift
//  SKYouTubeDemo
//
//  Created by Susheel Rao on 14/02/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit

class SettingsModel: NSObject {
    let name:SettingsName
    let imageName:String
    init(name:SettingsName,imageName:String) {
        self.name = name
        self.imageName = imageName
    }
}
enum SettingsName:String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case TermsPrivacy = "Terms & privacy policy"
    case sendFeedBack = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}
class SettingLauncher: NSObject,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    let blackView = UIView()
    let collectionView:UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    let cellId = "cellId"
    let heightofCell:CGFloat = 50
    let settingsArray:[SettingsModel] =
    {
       return [SettingsModel(name: .Settings, imageName:"settings"),SettingsModel(name: .TermsPrivacy, imageName:"lock"),SettingsModel(name: .sendFeedBack, imageName:"feedback"),SettingsModel(name: .Help, imageName:"Help"),SettingsModel(name: .SwitchAccount, imageName:"Switch_Account"),SettingsModel(name: .Cancel, imageName:"Cancel")]
    }()
    var homeVC:HomeController?
     func showSettings()
    {
        print("MoreOptionCliked")
        if let window = UIApplication.shared.keyWindow
        {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let height:CGFloat = CGFloat(settingsArray.count) * heightofCell
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            collectionView.isScrollEnabled = false
            blackView.frame = window.frame
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame  = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }, completion: nil)
        }
    }
     @objc func handleDismiss(setting:SettingsModel)
    {
       
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow
            {
                self.collectionView.frame = CGRect(x:0, y:window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed:Bool) in
            
                if  setting.name != .Cancel
                {
                    self.homeVC?.showViewController(setting: setting)
                }
        }
    }
    override init() {
        super.init()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.setting = settingsArray[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let setting = self.settingsArray[indexPath.row]
        handleDismiss(setting: setting)
    }
}
