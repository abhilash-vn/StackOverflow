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
      

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
