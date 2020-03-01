//
//  SONetworkManagerTests.swift
//  StackOverflowTests
//
//  Created by Viswambharan Nikitha, Abhilash on 01/03/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import XCTest
@testable import StackOverflow

/// A mock session that will be used in place of session to mock
class SOMockNetworkSession: NetworkSession {
    
    var data: Data?
    var error: Error?
    var response: URLResponse?
    
    func loadData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, response, error)
    }
}

class SONetworkManagerTests: XCTestCase {
    
    // Mock session for network manager
    let mockNetworkSession = SOMockNetworkSession()
    
    func test_NetworkManagerForDataRetrieval() {
        
        // Create data and tell the session to always return it
        let data = Data(base64Encoded: "dummy")
        mockNetworkSession.data = data
        
        let sut = SONetworkManager(session: mockNetworkSession)
        var dataRetrieved: Data?
        sut.fetchData(from: "url") { (data, _, _) in
            dataRetrieved = data
        }
        
        XCTAssertEqual(dataRetrieved, data)
    }
    
    func test_NetworkManagerForResponseRetrieval() {
  
        // Create response and tell the session to always return it
        let url = URL(string: "url")!
        let mockResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        mockNetworkSession.response = mockResponse
        
        let sut = SONetworkManager(session: mockNetworkSession)
        var responseRetrieved: URLResponse?
        sut.fetchData(from: "url") { (_, response, _) in
            responseRetrieved = response
        }
        
        XCTAssertEqual(responseRetrieved, mockResponse)
    }
    
    func test_NetworkManagerForErrorRetrieval() {

        // Create error and tell the session to always return it
        let error = SONetworkError.decodingFailed
        mockNetworkSession.error = error
        
        let sut = SONetworkManager(session: mockNetworkSession)
        var errorRetrieved: SONetworkError?
        sut.fetchData(from: "url") { (_, _, error) in
            errorRetrieved = error as? SONetworkError
        }
        
        XCTAssertTrue(errorRetrieved! == error)
    }
    

}
