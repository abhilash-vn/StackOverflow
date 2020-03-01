//
//  SOTableHelper.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 01/03/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation
import UIKit

class SOTableViewHelper {
    
    class func getTableErrorLabel(_ message:String, onTable table: UITableView) -> UILabel {
        
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: table.bounds.size.width, height: table.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
//        table.backgroundView = messageLabel
        table.separatorStyle = .none
        
        return messageLabel
    }
}
