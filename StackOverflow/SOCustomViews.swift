//
//  CustomViews.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation
import UIKit

//class ShadowedTextField: UITextField {
//    
//    required init?(coder aDecoder: NSCoder) {
//        
//        super.init(coder: aDecoder)
//        layer.borderWidth = 1.0
//        layer.borderColor = UIColor.systemGray.cgColor
//        layer.cornerRadius = 5.0
//      
//        layer.shadowColor = UIColor.systemGray.cgColor
//        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
//        layer.shadowRadius = 8
//        layer.shadowOpacity = 0.5
//    }
//}
//
//class BorderedButton: UIButton {
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        layer.borderWidth = 1.0
//        layer.borderColor = UIColor.systemGray.cgColor
//        layer.cornerRadius = 5.0
//        
//        layer.shadowColor = UIColor.systemGray.cgColor
//        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
//        layer.shadowRadius = 8
//        layer.shadowOpacity = 0.5
//        
//    }
//}

class SOShadowedUIView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.6
        
    }
}
