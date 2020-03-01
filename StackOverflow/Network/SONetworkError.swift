//
//  SONetworkError.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 01/03/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation

/// The network error object
enum SONetworkError: Error {
    
    case unknownError
    case badURL
    case invalidData
    case decodingFailed
    
}
