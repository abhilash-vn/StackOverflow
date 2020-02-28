//
//  RoadRequestResponseParser.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation

/// Any object that wants to parse response should conform to this.
protocol ResponseParsingService {
    
    /// Parse the response, will throw NetworkError
    /// - Parameter response: The response that should be parsed
    func parseResponse(response: URLResponse?) throws
}

struct SOResponseParser: ResponseParsingService {
    
    func parseResponse(response: URLResponse?) throws {
        
        // If there is no response object, there might be network error or unknown error
        guard let response = response as? HTTPURLResponse else {
            throw SONetworkError.unknownError
        }
        
        switch response.statusCode {
        case 404:
            throw SONetworkError.unrecognisedRoad
        case 429:
            throw SONetworkError.invalidCredentials
        default:
            break
        }
        
    }
    
}