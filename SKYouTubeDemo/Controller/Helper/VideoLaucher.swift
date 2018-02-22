//
//  VideoLaucher.swift
//  SKYouTubeDemo
//
//  Created by Susheel Rao on 19/02/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    let activityIndicator:UIActivityIndicatorView =
    {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
        }()
    lazy var pausePlayButton:UIButton =
    {
       let btn = UIButton(type: .system)
        let img = UIImage(named: "Pause")
        btn.setImage(img, for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    var isPlaying = false
    @objc func handlePause()
    {
        if player?.rate != 1
        {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "Pause"), for: .normal)
        }else
        {
            player?.pause()
             pausePlayButton.setImage(UIImage(named: "Play"), for: .normal)
        }
        //BRIAN VOONG code for play pause  below code
//        if isPlaying
//        {
//            player?.play()
//            pausePlayButton.setImage(UIImage(named: "Pause"), for: .normal)
//        }
//        else
//        {
//            player?.pause()
//            pausePlayButton.setImage(UIImage(named: "Play"), for: .normal)
//        }
//        isPlaying = !isPlaying
       // print("PauseTapped")
    }
    let controlsContainerView:UIView =
    {
       let view = UIView()
        view.backgroundColor = UIColor(white:0,alpha:1)
        return view
    }()
    let videoLengthLabel:UILabel =
    {
        let lbl = UILabel()
        lbl.text = "00:00"
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .right
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let currentTimeLabel:UILabel =
    {
        let lbl = UILabel()
        lbl.text = "00:00"
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    lazy var videoSlider:UISlider =
    {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named:"thumb"), for:.normal)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    @objc func handleSliderChange()
    {
        //print("sliderValue chages")
        if let duration = player?.currentItem?.duration
        {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                //do something
            })
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        controlsContainerView.frame = frame
        setUpPlayerView()
        setUpGradientLayer()
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        //add play pause button
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //set song length lable layout
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
       videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        //set constraints to current label
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        //set contraints to videoSlider
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(lessThanOrEqualTo: currentTimeLabel.rightAnchor ).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        backgroundColor = .black
        

    }
    var player:AVPlayer?
    private func setUpPlayerView()
    {
        let urlString = "http://techslides.com/demos/sample-videos/small.mp4"
        if let url = URL(string: urlString)
        {
             player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.videoGravity = .resizeAspect
            playerLayer.frame = self.frame
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            //Track player progress
            let interval = CMTime(value: 1, timescale: 2)
//            player!.addPeriodicTimeObserver(forInterval: interval , queue: DispatchQueue.main) { (CMTime) -> Void in
//                if self.player!.currentItem?.status == .readyToPlay {
//                   // let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
////                    let float = Float ( time )
//                    let time = CMTimeGetSeconds(self.player!.currentTime());
//                    let time1 = Int(time) % 60
//                   // let secondsTime = String(format: "%.02f", float)
//                    self.currentTimeLabel.text = "\(time1)"
////                    self.videoSlider.value = ;
//                }
//            }
            
            player?.addPeriodicTimeObserver(forInterval: interval,queue: DispatchQueue.main) { (elapsedTime: CMTime) -> Void in
              //  print("elapsedTime now:", CMTimeGetSeconds(elapsedTime))
                let second = CMTimeGetSeconds(elapsedTime)
                let secondString = String(format: "%02d",Int(second.truncatingRemainder(dividingBy: 60)))
                let minutesString = String(format: "%02d", Int(second/60))
                self.currentTimeLabel.text = "\(minutesString):\(secondString)"
                //lets move the slider thumb
                if let duration = self.player?.currentItem?.duration
                {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.videoSlider.value = Float(second/durationSeconds)
                }
                
            }
            player?.play()
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //this is when the player is ready and redering frames
        if keyPath == "currentItem.loadedTimeRanges"
        {
            activityIndicator.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
            if let duration = player?.currentItem?.duration
            {
                let seconds = CMTimeGetSeconds(duration)
                let secondText = String(format: "%02d", Int(seconds)  % 60)
                let minutesText = String(format: "%02d", Int(seconds)/60)
                videoLengthLabel.text = "\(minutesText):\(secondText)"
            }
        }
    }
   private  func setUpGradientLayer()
    {
        let gradienLayer =  CAGradientLayer()
        gradienLayer.frame = bounds
        gradienLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradienLayer.locations = [0.7,1.2]
        controlsContainerView.layer.addSublayer(gradienLayer)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class VideoLaucher:NSObject{
    func showVideoPlayer(){
        //print("showing video player animation...")
        if let keyWindow = UIApplication.shared.keyWindow
        {
            //let guide = keyWindow.rootViewController?.view.safeAreaLayoutGuide
            //let view = UIView(frame: keyWindow.frame)
            let view = UIView(frame: (keyWindow.rootViewController?.view.frame)!)
            view.backgroundColor  = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
           
            //16 X 9 is the aspect ratio of all HD Videos
            let playerheight = keyWindow.frame.width * 9/16
            
            let videoFrame = CGRect(x: keyWindow.frame.origin.x, y: 15, width: keyWindow.frame.width, height: playerheight)
            let videoPlayerView = VideoPlayerView(frame: videoFrame)
            videoPlayerView.clipsToBounds = true
            view.addSubview(videoPlayerView)
           // keyWindow.addSubview(view)
            keyWindow.rootViewController?.view.addSubview(view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
               // view.frame = keyWindow.frame
                view.frame=(keyWindow.rootViewController?.view.frame)!
            }, completion: { (complitedAnimation) in
                //may be we will do something here
                //UIApplication.shared.isStatusBarHidden = true
            })
        }
    }
}
