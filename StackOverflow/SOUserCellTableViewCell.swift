//
//  SOUserCellTableViewCell.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 28/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import UIKit

protocol CachedImageView {
    
    func setImageFromUrl(_ imageURL :String)
    func cacheImage(image: UIImage, for urlString: String)
    
}

class UIImageViewCached: UIImageView, CachedImageView {
    
    private static var cachedImages = [String: UIImage]()
    
    func setImageFromUrl(_ imageURL :String) {
        
        if let image = UIImageViewCached.cachedImages[imageURL] {
            self.image = image
            return
        }
        
        URLSession.shared.dataTask( with: NSURL(string:imageURL)! as URL, completionHandler: {
            (data, response, error) -> Void in
            
            print("Fetched Image: \(imageURL)")
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    
                    self.cacheImage(image: image, for: imageURL)
                    self.image = image
                }
            }
        }).resume()
    }
    
    func cacheImage(image: UIImage, for urlString: String) {
        
        UIImageViewCached.cachedImages[urlString] = image
    }
    
}

class SOUserCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var reputationLabel: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageViewCached!
    
    @IBOutlet weak var buttonViewZeroHeightConstraint: NSLayoutConstraint!
    
    private var userData: SOUserViewData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupWith(user: SOUserViewData) {
        
        userData = user
        
        userNameLabel.text = userData.name
        reputationLabel.text = String(userData.reputation)
        followingLabel.text = userData.isFollowing ? "Following" : ""
        
        profileImageView?.setImageFromUrl(userData.profileImageURL)
        
    }
    
    @IBAction func blockButtonAction(_ sender: Any) {
        self.userData.isBlocked = true
    }
    
    @IBAction func followButtonAction(_ sender: Any) {
        self.userData.isFollowing = !(self.userData.isFollowing)
        followingLabel.text = userData.isFollowing ? "Following" : ""
    }
    
    func toggleExpandedState() {
        
        guard var validDataViewModel = userData, !validDataViewModel.isBlocked else {
            return
        }
        
        validDataViewModel.isInExpandedState = !validDataViewModel.isInExpandedState
        validDataViewModel.isInExpandedState ? expandCell() : collapseCell()
        
    }
    
    func expandCell() {
        buttonViewZeroHeightConstraint.isActive = false
    }
    
    func collapseCell() {
        buttonViewZeroHeightConstraint.isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
