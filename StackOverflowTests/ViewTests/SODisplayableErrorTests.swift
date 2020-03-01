//
//  SODisplayableErrorTests.swift
//  StackOverflowTests
//
//  Created by Viswambharan Nikitha, Abhilash on 01/03/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import XCTest
@testable import StackOverflow

class SODisplayableErrorTests: XCTestCase {

    func test_DisplayableErrorInitialisation() {
        
        let sut = SODisplayableError(message: "test")
        XCTAssert(sut.message == "test")
    }
    
    func test_DisplayableErrorInitialisationWithBadURLError() {
           
        let sut = SODisplayableError(error: SONetworkError.badURL)
           XCTAssert(sut.message == "The application is configured wrong.\nSomeone is getting fired!")
       }
    
    func test_DisplayableErrorInitialisationWithUnknownError() {
        
     let sut = SODisplayableError(error: SONetworkError.unknownError)
        XCTAssert(sut.message == "Something went wrong. No idea why!\nDo we have a network connection?")
    }
    
    func test_DisplayableErrorInitialisationWithNetworkConnectionError() {
           
        let sut = SODisplayableError(error: SONetworkError.networkConnection)
           XCTAssert(sut.message == "Seems like we can't connect to the network!\nIs the wifi turned off?")
       }
    
    func test_DisplayableErrorInitialisationWithInvalidDataError() {
        
     let sut = SODisplayableError(error: SONetworkError.invalidData)
        XCTAssert(sut.message == "Our server is acting up. Can we try again after some time.")
    }
    
    func test_DisplayableErrorInitialisationWithDecodingFailedError() {
        
     let sut = SODisplayableError(error: SONetworkError.decodingFailed)
        XCTAssert(sut.message == "Our server is not quacking right. Is this an old version of the app?")
    }

}
