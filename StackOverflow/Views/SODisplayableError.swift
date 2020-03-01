//
//  SODisplayableError.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation

protocol DisplayableError {
    var message: String { get }
}

struct SODisplayableError: DisplayableError {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
    
    init(error: SONetworkError) {
        message = error.userFriendlyMessage
    }
}

extension SONetworkError {
        
    var userFriendlyMessage: String {
        
        switch self {
            
        case .unknownError:
            return "Something went wrong. No idea why!\nDo we have a network connection?"
        case .networkConnection:
            return "Seems like we can't connect to the network!\nIs the wifi turned off?"
        case .badURL:
            return "The application is configured wrong.\nSomeone is getting fired!"
        case .invalidData:
            return "Our server is acting up. Can we try again after some time."
        case .decodingFailed:
            return "Our server is not quacking right. Is this an old version of the app?"
            
        }
        
    }
    
}
