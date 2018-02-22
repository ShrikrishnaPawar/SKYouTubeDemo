//
//  feedCell.swift
//  SKYouTubeDemo
//
//  Created by Susheel Rao on 16/02/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit

class feedCell: BaseCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 
    lazy var collectionView:UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
     let  cellId = "cellId"
    var videos:[VideoModel]?
    func fetchVideo() {
        ApiService.sharedInstance.fetchVideos { (videos:[VideoModel]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    override func setUpView() {
        fetchVideo()
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsetsMake( 20, 0, 0, 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(20, 0, 0, 0)
       // collectionView.isPagingEnabled = true
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //here 16/9 = 1.778 we have taken bcz 1280/720 = 1.778 and 1920/1080 = 1.778 so have multiply with ratio
        let height = (frame.width - 16 - 16) * 9 / 16
        /*        let totalHeight = height + topConstraints + titleLabelTopSpace+profileImgeHeight+TitleLabeltrallingSpace i.e VerticalConstraints*/
        let totalHeight = height + 16 + 88
        
        return CGSize(width: frame.width, height: totalHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLaucher()
        videoLauncher.showVideoPlayer()
    }

}
