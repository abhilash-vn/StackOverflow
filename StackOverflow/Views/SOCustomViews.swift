//
//  CustomViews.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation
import UIKit

class SOBorderedButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemGray.cgColor
        layer.cornerRadius = 5.0
        
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        
    }
}

class SOShadowedUIView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.6
        
    }
}

protocol CachedImageView {
    
    func setImageFromUrl(_ imageURL: String)
    func cacheImage(_ image: UIImage, for urlString: String)
    
}

class UIImageViewCached: UIImageView, CachedImageView {
    
    private static var cachedImages = [String: UIImage]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemGray.cgColor
        layer.cornerRadius = 5.0
    }
    
    func setImageFromUrl(_ imageURL: String) {
        
        if let image = UIImageViewCached.cachedImages[imageURL] {
            self.image = image
            return
        }
        
        URLSession.shared.dataTask(with: NSURL(string:imageURL)! as URL, completionHandler: {
            (data, response, error) -> Void in
            
            print("Fetched Image: \(imageURL)")
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    
                    self.cacheImage(image, for: imageURL)
                    self.image = image
                }
            }
        }).resume()
    }
    
    func cacheImage(_ image: UIImage, for urlString: String) {
        
        UIImageViewCached.cachedImages[urlString] = image
    }
    
}

