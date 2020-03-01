//
//  SONetworkTests.swift
//  StackOverflowTests
//
//  Created by Viswambharan Nikitha, Abhilash on 01/03/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import XCTest
@testable import StackOverflow

class SONetworkTests: XCTestCase {
    
    
    class MockNetworkSerice: NetworkService {
        
        var url: String?
        
        func fetchData(from urlString: String, completion: @escaping SONetworkTests.MockNetworkSerice.completionHandler) {
            self.url = urlString
            completion(nil,nil,nil)
        }
    }


    func test_NetworkManager() {
        
        let sut = MockNetworkSerice()
        sut.fetchData(from: "testable") { (_,_,_) in
            XCTAssertEqual(sut.url, "testable")
        }
        
    }

}
