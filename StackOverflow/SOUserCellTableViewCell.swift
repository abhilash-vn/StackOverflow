//
//  SOUserCellTableViewCell.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 28/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import UIKit

class SOUserCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var reputationLabel: UILabel!
     
    @IBOutlet weak var followingLabel: UILabel!
     
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var buttonViewZeroHeightConstraint: NSLayoutConstraint!
      
    private var userData: SOUserViewData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupWith(user: SOUserViewData) {
        
        self.userData = user
        
        userNameLabel.text = user.name
        reputationLabel.text = String(user.reputation)
        followingLabel.text = user.isFollowing ? "Following" : ""
        
    }
    
    @IBAction func blockButtonAction(_ sender: Any) {
        self.userData?.isBlocked = true
    }
    
    @IBAction func followButtonAction(_ sender: Any) {
        self.userData.isFollowing = !(self.userData.isFollowing)
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
