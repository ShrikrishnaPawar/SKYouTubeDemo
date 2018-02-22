//
//  SubscriptionsCell.swift
//  SKYouTubeDemo
//
//  Created by Susheel Rao on 19/02/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit

class SubscriptionsCell: feedCell {
    
    override func fetchVideo() {
        ApiService.sharedInstance.fetchSubscriptionsFeeds(completion: { (videos:[VideoModel]) in
            self.videos = videos
            self.collectionView.reloadData()
        })
    }
}
