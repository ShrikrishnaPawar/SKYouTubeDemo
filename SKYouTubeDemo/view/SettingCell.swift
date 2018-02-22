//
//  SettingCell.swift
//  SKYouTubeDemo
//
//  Created by Susheel Rao on 15/02/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit
class SettingCell: BaseCell {
    
    override var isHighlighted: Bool
        {
        didSet
        {
            backgroundColor = isHighlighted ? .darkGray : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    var setting:SettingsModel? {
        didSet{
            if let name = setting?.name.rawValue
            {
                nameLabel.text = name
            }
            if let imageName = setting?.imageName
            {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    let nameLabel:UILabel =
    {
        let lbl = UILabel()
        lbl.text = "Setting"
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textColor = .darkGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let iconImageView:UIImageView =
    {
        let img = UIImageView()
        img.image = UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate)
        img.contentMode = .scaleAspectFit
        img.tintColor = .darkGray; img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    override func setUpView() {
   // backgroundColor = UIColor.blue
        
     addSubview(nameLabel)
     addSubview(iconImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView,nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
