//
//  ApiService.swift
//  SKYouTubeDemo
//
//  Created by Susheel Rao on 16/02/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit

class ApiService: NSObject {
static let sharedInstance = ApiService()
 let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    func fetchVideos(completion:@escaping ([VideoModel])->())
    {
        //let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
//        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json") { (videos) in
//            completion(videos)
//        }
//        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
        fetchFeedForUrlString(urlString: "\(baseUrl)/home_num_likes.json", completion: completion)
    }
    func fetchTrendingFeeds(completion:@escaping ([VideoModel])->())
    {
//        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json")
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json",completion:completion)
    }
    func fetchSubscriptionsFeeds(completion:@escaping ([VideoModel])->())
    {
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json",completion:completion)
    }
    func fetchFeedForUrlString(urlString:String,completion:@escaping ([VideoModel])->())
    {
        let url = NSURL(string: urlString)
        //let request = URLRequest(url:url! as URL)
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) -> Void in
            print("Task completed")
            
            
            if let data = data {
                do {
                    
                    
                      if  let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String:Any]]
                      {
                        // print(jsonResult)
                        DispatchQueue.main.async {
                            completion(jsonResult.map({return VideoModel(dictionary:$0)}))
                        }
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
}
/*
 let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
 
 print(jsonResult)
 var videos = [VideoModel]()
 for item in jsonResult as! [[String:Any]]
 {
 let videoModel = VideoModel()
 videoModel.title = item["title"] as? String ?? "No Title"
 videoModel.thumbnailImageName = item["thumbnail_image_name"] as? String ?? nil
 let channelDict = item["channel"] as? [String:Any] ?? ["key":"No Image"]
 print(channelDict)
 //                        guard let channelDict = item["channel "] as? [String:Any]else{continue}
 let channelModel = ChannelModel()
 if  (channelDict["name"] as? String) != nil
 {
 channelModel.name = channelDict["name"] as? String
 
 }else {continue}
 if (channelDict["profile_image_name"] as? String) != nil
 {
 
 channelModel.profileImageName = channelDict["profile_image_name"] as? String
 
 }else {continue}
 if (channelDict["profile_image_name"] as? String) != nil && (channelDict["name"] as? String) != nil
 {
 videoModel.channelModel = channelModel
 }
 videos.append(videoModel)
 }
 DispatchQueue.main.async {
 completion(videos)
 }
 */
