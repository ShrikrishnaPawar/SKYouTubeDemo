//
//  Extensions.swift
//  SKYouTubeDemo
//
//  Created by Susheel Rao on 13/02/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor
    {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
extension UIView
{
    func addConstraintsWithFormat(format:String,views:UIView...)  {
        var viewsDictionary = [String:UIView]()
        
        for (index,view) in views.enumerated()
        {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
let imageCache = NSCache<NSString,UIImage>()
class CoustomImageView:UIImageView
{
    var imageCatch = NSCache<AnyObject, AnyObject>()
    var imgUrlString:String?
    func loadImageUsingUrlString(urlString:String)
    {
     imgUrlString = urlString
        let url = URL(string:urlString)
        image = nil
        if let imageFromCatch = imageCatch.object(forKey: urlString as NSString)as? UIImage
        {
            DispatchQueue.main.async {
                self.image = imageFromCatch
            }
            return
        }
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil
            {
                print(error ?? "SKerror")
                return
            }
            DispatchQueue.main.async {
                let imageCatch = UIImage(data: data!)
                
                if self.imgUrlString == urlString
                {
                    self.image = imageCatch
                }
                self.imageCatch.setObject(imageCatch!, forKey: urlString as NSString)//UIImage(data: data!)
            }
        }).resume()
    }
}
