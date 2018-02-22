//
//  VideoCell.swift
//  SKYouTubeDemo
//
//  Created by Susheel Rao on 13/02/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit
class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    func setUpView()  {
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class VideoCell: BaseCell  {
   
    var video:VideoModel? {
        didSet{
            titleLabel.text = video?.title
            setThumbNailImages()
            setProfileImages()
            
             if let chanelName = video?.channel?.name
            {
               
                if let numberOfViews = video?.number_of_views
                    {
                        let numberFormater = NumberFormatter()
                        numberFormater.numberStyle = .decimal
                        let subTitleText = "\(chanelName) • \(numberFormater.string(from: numberOfViews)!) • 2 year ago"
                        //print(subTitleText)
                        subTitleTextView.text = subTitleText
                }
            }
            //measure title text
            if let title = video?.title
            {
                let size = CGSize(width: frame.width-16-44-8-16, height: 1000)
                let options = NSStringDrawingOptions.usesLineFragmentOrigin
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes:[NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)], context: nil)
                if estimatedRect.size.height > 20
                {
                    titleLableHeightConstraints?.constant = 44
                } else
                {
                    titleLableHeightConstraints?.constant = 20
                }
            }
        }
    }
    func setThumbNailImages() {
        if let thumbImgUrl = video?.thumbnail_image_name
        {
             thumbnailImage.loadImageUsingUrlString(urlString: thumbImgUrl)
        }
//        thumbnailImage.image = UIImage(named:(video?.thumbnailImageName)!)
    }
    func setProfileImages() {
        if let thumbImgUrl = video?.channel?.profile_image_name
        {
            profileImageView.loadImageUsingUrlString(urlString: thumbImgUrl)
            
        }
    }
    let thumbnailImage:CoustomImageView =
    {
        let imageView = CoustomImageView()
        imageView.image = #imageLiteral(resourceName: "demo1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let sepearatorView:UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    let profileImageView:CoustomImageView =
    {
        let imageView = CoustomImageView()
        imageView.image = #imageLiteral(resourceName: "1")
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill  
        return imageView
    }()
    let titleLabel:UILabel =
    {
        let label = UILabel()
        // label.backgroundColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift- Blank Space"
        label.numberOfLines = 2
        return label
    }()
    let subTitleTextView:UITextView =
    {
        let textView = UITextView()
        //        textView.backgroundColor = .red
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    var titleLableHeightConstraints:NSLayoutConstraint?
    override func setUpView() {
        addSubview(thumbnailImage)
        addSubview(sepearatorView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImage)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: profileImageView)
        //verticaleConstraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImage,profileImageView,sepearatorView )
        addConstraintsWithFormat(format: "H:|[v0]|", views: sepearatorView)
        
        
        //Top Constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImage, attribute: .bottom, multiplier: 1, constant: 8))
        //left Constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        //Right Constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImage, attribute: .right, multiplier: 1, constant: 0))
        //height Constraints
        titleLableHeightConstraints = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLableHeightConstraints!)
        
        //Top Constraints
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left Constraints
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        //Right Constraints
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImage, attribute: .right, multiplier: 1, constant: 0))
        //height Constraints
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
    
    
}
