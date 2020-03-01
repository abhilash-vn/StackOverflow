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
    /// - Parameter dataManager: The data manager that will be used by the app, this will be provided by default
    func start(dataManager: DataService)
    
    /// Stop coordinator and unload and release everything
    func stop()
    
    /// The root view controller of the current coordinator
    var rootViewController: UIViewController? { get }
    
}
