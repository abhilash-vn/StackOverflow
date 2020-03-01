//
//  SOErrorParserTests.swift
//  StackOverflowTests
//
//  Created by Viswambharan Nikitha, Abhilash on 01/03/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import XCTest
@testable import StackOverflow

class SOErrorParserTests: XCTestCase {
    
    let sut = SOErrorParser()
    var errorRetrieved: SONetworkError?
    
    func test_ErrorParserForBadURL() {
        
        let error = NSError(domain: "http", code: -1002, userInfo: nil)

        do {
            try sut.parseError(error: error)
        } catch let parsedError {
           errorRetrieved = parsedError as? SONetworkError
        }
        
        XCTAssertTrue(errorRetrieved! == .badURL)

    }
    
    func test_ErrorParserForNetworkConnection() {
        
        let error = NSError(domain: "http", code: -1009, userInfo: nil)
        
        do {
            try sut.parseError(error: error)
        } catch let parsedError {
           errorRetrieved = parsedError as? SONetworkError
        }
        
        XCTAssertTrue(errorRetrieved! == .networkConnection)

    }
    
    func test_ErrorParserForOtherErrors() {
        
        let error = NSError(domain: "http", code: 1000, userInfo: nil)
        
        do {
            try sut.parseError(error: error)
        } catch let parsedError {
           errorRetrieved = parsedError as? SONetworkError
        }
        
        XCTAssertTrue(errorRetrieved! == .unknownError)

    }
    

}
