//
//  ViewController.swift
//  SKYouTubeDemo
//
//  Created by Susheel Rao on 12/02/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

//    var video:[VideoModel] =
//    {
//    var channelModel = ChannelModel()
//        channelModel.name = "KaneyIsTheBestChannel"
//        channelModel.profileImageName = "1"
//     var videoModel = VideoModel()
//        videoModel.title = "Taylor Swift - Blank Space"
//        videoModel.thumbnailImageName = "demo1"
//        videoModel.channelModel = channelModel
//        videoModel.numberOfViews = 23984308593
//        var channelModel1 = ChannelModel()
//        channelModel1.name = "KaneyIsTheBestChannel"
//        channelModel1.profileImageName = "2"
//    var videoModel1 = VideoModel()
//        videoModel1.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
//        videoModel1.channelModel = channelModel1
//        videoModel1.thumbnailImageName = "demo2"
//        videoModel1.numberOfViews = 788525967
//        return [videoModel,videoModel1]
//    }()
    static let cellId = "cellId"
    static let trendingCellId = "trendingCellId"
    static let subscriptionCellId = "subscriptionCellId"
    
    let arrTitles = ["Home","Trending","Subscriptions","Account"]
    lazy var settingLaucher:SettingLauncher =
        {
            // this line of code execute only when homeVC varibel instance is nil
            let settingLauncher = SettingLauncher()
            settingLauncher.homeVC = self //Self not able to written with out Lazy loading var varible so we have intialize setting laucher variable with lazy var
            return settingLauncher
    }()
    lazy var menuBar:MenuBar =
        {
            let mb = MenuBar()
            mb.homeVC = self
            return mb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setCollectionView()
        setUpMenuBar()
        setUpNavBarButton()
    }
    func setCollectionView()  {
        collectionView?.backgroundColor = UIColor.white
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        {
       flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
//        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.register(feedCell.self, forCellWithReuseIdentifier: HomeController.cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: HomeController.trendingCellId)
        collectionView?.register(SubscriptionsCell.self, forCellWithReuseIdentifier: HomeController.subscriptionCellId)
        //SubscriptionsCell

        collectionView?.contentInset = UIEdgeInsetsMake( 50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.isPagingEnabled = true
    }
    func setUpNavBarButton(){
        let searchImg = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImg, style: .plain, target: self, action: #selector(searchAction))
        let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(moreOptionAction))
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem,searchBarButtonItem]
    }
    @objc func searchAction()
    {
        print("SearchClicked")
        //scrollToMenuIndex(menuIndex: 2)
    }
    func scrollToMenuIndex(menuIndex:Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .init(rawValue: 0), animated: true)
        setTitleForIndex(index: menuIndex)
    }
    private func setTitleForIndex(index:Int)
    {
        if let titleLabel = navigationItem.titleView as? UILabel
        {
            titleLabel.text = "  \(arrTitles[index])"
        }
    }
    @objc func moreOptionAction()
    {
        print("MoreOptionCliked")
//        settingLaucher.homeVC = self everytime new instance is set ot homeVC variable which is not good so we user to create lazy instance for stting launcher
        settingLaucher.showSettings()
      // showViewController()
        
    }
    func showViewController(setting:SettingsModel) {
        let demoVC = UIViewController()
       demoVC.view.backgroundColor = .white;
        navigationController?.navigationBar.tintColor = .white
        
        demoVC.title = setting.name.rawValue; navigationController?.pushViewController(demoVC, animated: true)
    }
    private  func setUpMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
       let guide = view.safeAreaLayoutGuide
       
       menuBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizonatalLeftBarAnchorConstraints?.constant = scrollView.contentOffset.x / 4
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       // print(targetContentOffset.pointee.x/view.frame.width)
        let item = targetContentOffset.pointee.x/view.frame.width
        let indexPath = IndexPath(item: Int(item), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init(rawValue: 0))
        setTitleForIndex(index: Int(item))
    }
    //MARK:- collection View Delegate / Datasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier:String
        
        if indexPath.item == 1
        {
            identifier = HomeController.trendingCellId
        }else if indexPath.item == 2
        {
            identifier = HomeController.subscriptionCellId
        }else
        {
            identifier = HomeController.cellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


