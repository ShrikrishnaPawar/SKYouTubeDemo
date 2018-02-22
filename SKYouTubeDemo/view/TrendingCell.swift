//
//  TrendingCell.swift
//  SKYouTubeDemo
//
//  Created by Susheel Rao on 19/02/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit

class TrendingCell: feedCell {
  
    override func fetchVideo() {
    ApiService.sharedInstance.fetchTrendingFeeds(completion: { (videos:[VideoModel]) in
        self.videos = videos
        self.collectionView.reloadData()
        })
    }
}
