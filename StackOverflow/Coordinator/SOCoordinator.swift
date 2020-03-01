//
//  SOCoordinator.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 29/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation
import UIKit


/// Coordinator protocol, any main or child coordinator should conform to this
protocol SOCoordinator: AnyObject {
    
    /// Start the coordinator, ideally present view and inject dependencies
    func start()
    
    /// Stop coordinator and unload and release everything
    func stop()
    
    /// The root view controller of the current coordinator
    var rootViewController: UIViewController { get }
    
}

// Making the stop function optional
extension SOCoordinator {
    
    func stop() {}
}
