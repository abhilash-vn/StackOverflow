//
//  ErrorParser.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation

/// Any object that wants to parse error should conform to this.
protocol ErrorParsingService {
    
    /// Parse the error from service. WIll throw Network error
    /// - Parameter error: The error that should be processed.
    func parseError(error: Error?) throws
}

struct SOErrorParser: ErrorParsingService {
    
    func parseError(error: Error?) throws {
        
        // If there is no error, just return and continue parsing response and data
        guard let error = error as NSError? else {
            return
        }
        
        // Look for error codes and return an App specific error
        switch error.code {
        case -1002:
            throw SONetworkError.badURL
        case -1009:
            throw SONetworkError.networkConnection
        default:
            break
        }
        
        print("Error : \(error)")
        print("Code : \(error.code)")
        print("Description : \(error.localizedDescription)")
        
    }
}
