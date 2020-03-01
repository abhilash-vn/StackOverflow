//
//  SOUserCellTableViewCell.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 28/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import UIKit

typealias blockButtonTappedCompletion = (SOUserViewData) -> Void
typealias followButtonTappedCompletion = (SOUserViewData) -> Void

class SOUserCellTableViewCell: UITableViewCell {
    
    var blockAction: blockButtonTappedCompletion!
    var followAction: blockButtonTappedCompletion!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageViewCached!
    
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var greyedOutView: UIView!
    
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
        setFollowingState()
        
        profileImageView?.setImageFromUrl(userData.profileImageURL)
        greyedOutView.isHidden = !userData.isBlocked
        
        userData.isInExpandedState ? expandCell() : collapseCell()
        
    }
    
    func toggleExpandedState() {
        
        guard var validDataViewModel = userData else {
            return
        }
        
        validDataViewModel.isInExpandedState = !validDataViewModel.isInExpandedState
        validDataViewModel.isInExpandedState ? expandCell() : collapseCell()
        
    }
    
    @IBAction func blockButtonAction(_ sender: Any) {
        
        blockAction(userData)
        greyedOutView.isHidden = false
       
    }
    
    @IBAction func unblockButtonAction(_ sender: Any) {
        
        blockAction(userData)
        greyedOutView.isHidden = true
        
        
    }
    
    @IBAction func followButtonAction(_ sender: Any) {
        
        followAction(userData)
        setFollowingState()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

private extension SOUserCellTableViewCell {
    
    func expandCell() {
        buttonViewZeroHeightConstraint.isActive = false
    }
    
    func collapseCell() {
        buttonViewZeroHeightConstraint.isActive = true
    }
    
    func setFollowingState() {
        
        followingLabel.text = userData.isFollowing ? "Following" : ""
        followButton.setTitle((userData.isFollowing ? "UnFollow" : "Follow"), for: .normal)
    }
}
