//
//  SOConfiguration.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation

/// Network API
enum SOConfiguration {
    
    /// The base url for the network service
    static var baseURLString: String {
        return "https://api.stackexchange.com/2.2/users?pagesize=20&order=desc&sort=reputation&site=stackoverflow"
    }
}

