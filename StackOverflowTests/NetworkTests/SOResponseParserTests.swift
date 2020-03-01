//
//  SOResponseParserTests.swift
//  StackOverflowTests
//
//  Created by Viswambharan Nikitha, Abhilash on 01/03/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import XCTest
@testable import StackOverflow


class SOResponseParserTests: XCTestCase {
    
    let sut = SOResponseParser()
    var errorRetrieved: SONetworkError?

    func test_ResponseParserForBadURL() {
        
        let url = URL(string: "url")!
        let mockResponse = HTTPURLResponse(url: url, statusCode: 400, httpVersion: "HTTP/1.1", headerFields: nil)!
        
        do {
            try sut.parseResponse(response: mockResponse)
        } catch let parsedError {
           errorRetrieved = parsedError as? SONetworkError
        }
        
        XCTAssertTrue(errorRetrieved! == .badURL)
    }
    
    func test_ResponseParserForProperData200() {
        
        let url = URL(string: "url")!
        let mockResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        
        do {
            try sut.parseResponse(response: mockResponse)
        } catch let parsedError {
           errorRetrieved = parsedError as? SONetworkError
        }
        
        XCTAssertNil(errorRetrieved)
    }
    
    func test_ResponseParserForNoResponse() {

        do {
            try sut.parseResponse(response: nil)
        } catch let parsedError {
           errorRetrieved = parsedError as? SONetworkError
        }
        
         XCTAssertTrue(errorRetrieved! == .unknownError)
    }

}
