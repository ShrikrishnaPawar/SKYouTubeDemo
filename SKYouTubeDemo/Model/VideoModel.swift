//
//  VideoModel.swift
//  SKYouTubeDemo
//
//  Created by Susheel Rao on 13/02/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit
class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercasedFirstCharacter = String(key.first!).uppercased()
        let range = NSMakeRange(0, 1)
        let selectorString1 = NSString(string:key).replacingCharacters(in: range, with: uppercasedFirstCharacter)
        let selector = NSSelectorFromString("set\(selectorString1)" )
        let respond = self.responds(to: selector)
        
        if !respond
        {
            return
        }
        super.setValue(value, forKey: key)
    }
}
class VideoModel: SafeJsonObject {
    
    var thumbnail_image_name:String?
    var title:String?
    var number_of_views:NSNumber?
    var uploadDate:NSDate?
    var channel:ChannelModel?
    var duration: NSNumber?
   init(dictionary:[String:Any]) {
        super.init()
    self.title = dictionary["title"] as? String ?? "No Title"
    self.thumbnail_image_name = dictionary["thumbnail_image_name"] as? String ?? nil
    self.number_of_views = dictionary ["number_of_views"] as? NSNumber ?? 0
    self.channel = ChannelModel()
    if let channelDict = dictionary["channel"] as? [String:Any]
    {
        if  (channelDict["name"] as? String) != nil
        {
            self.channel?.name = channelDict["name"] as? String
        }
        if (channelDict["profile_image_name"] as? String) != nil
        {
            self.channel?.profile_image_name = channelDict["profile_image_name"] as? String
        }
    }
 }
    //$_Krishna below lines of code add when variable name and response key must be same then uncomment it
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "channel"
//        {
//            self.channel = ChannelModel()
//            self.channel?.setValuesForKeys(value as! [String:Any])
//        }else
//        {
//            super.setValue(value, forKey: key)
//        }
//    }
//    init(dictionary:[String:Any]) {
//        super.init()
//        setValuesForKeys(dictionary)
//    }
}
class ChannelModel:SafeJsonObject {
    
    var name:String?
    var profile_image_name:String?
}
