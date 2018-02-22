//
//  MenuBar.swift
//  SKYouTubeDemo
//
//  Created by Susheel Rao on 13/02/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit

class MenuBar: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView:UICollectionView =
    {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.delegate = self
        cv.dataSource = self
       return cv
    }()
    let cellId = "cellId"
    let images = ["home","trending","subscription","Accont"]
    var homeVC:HomeController?
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addConstraintsWithFormat(format:"H:|[v0]|", views:collectionView)
        addConstraintsWithFormat(format:"V:|[v0]|", views:collectionView)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0) 
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition:UICollectionViewScrollPosition.centeredHorizontally)
        setupHorizontalBar()
    }
    var horizonatalLeftBarAnchorConstraints:NSLayoutConstraint?
    func setupHorizontalBar()  {
        let horizonatalBarView = UIView()
        horizonatalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
horizonatalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizonatalBarView)
        let guide = self.safeAreaLayoutGuide
        
   horizonatalLeftBarAnchorConstraints = horizonatalBarView.leftAnchor.constraint(equalTo: guide.leftAnchor)
        horizonatalLeftBarAnchorConstraints?.isActive = true
        horizonatalBarView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        horizonatalBarView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 1/4).isActive = true
        horizonatalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named:images[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        
        //cell.backgroundColor = UIColor.blue
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.item)
//        let x = CGFloat(indexPath.item) * frame.width / 4
//    horizonatalLeftBarAnchorConstraints?.constant = x
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
        homeVC?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class MenuCell: BaseCell {
    
    let imageView:UIImageView =
    {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "home")
        return img
    }()
    override var isHighlighted:Bool
        {
        didSet
        {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
         //   print(123)
        }
    }
    override var isSelected: Bool
        {
        didSet
        {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    override func setUpView() {
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
       addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //backgroundColor = UIColor.yellow
    }
}
