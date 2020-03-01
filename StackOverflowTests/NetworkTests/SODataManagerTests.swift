//
//  SODataManagerTests.swift
//  StackOverflowTests
//
//  Created by Viswambharan Nikitha, Abhilash on 01/03/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import XCTest
@testable import StackOverflow

class SOMockNetworkManager: NetworkService {
    
    private let session: SOMockNetworkSession
    
    required init(session: NetworkSession) {
        self.session = (session as? SOMockNetworkSession)!
    }
    
    func fetchData(from urlString: String, completion: @escaping completionHandler) {
        completion(session.data,session.response,session.error)
    }
    
}

class SODataManagerTests: XCTestCase {
    
    let validJsonString = """
            {
              "items": [
                {
                  "badge_counts": {
                    "bronze": 1368,
                    "silver": 1434,
                    "gold": 146
                  },
                  "account_id": 24377,
                  "is_employee": false,
                  "last_modified_date": 1582135504,
                  "last_access_date": 1582816953,
                  "reputation_change_year": 9287,
                  "reputation_change_quarter": 9287,
                  "reputation_change_month": 4360,
                  "reputation_change_week": 812,
                  "reputation_change_day": 100,
                  "reputation": 649764,
                  "creation_date": 1233672960,
                  "user_type": "registered",
                  "user_id": 61974,
                  "location": "Denmark",
                  "website_url": "http://careers.stackoverflow.com/markbyers/",
                  "link": "https://stackoverflow.com/users/61974/mark-byers",
                  "profile_image": "https://www.gravatar.com/avatar/ad240ed5cc406759f0fd72591dc8ca47?s=128&d=identicon&r=PG",
                  "display_name": "Mark Byers"
                }
              ],
              "has_more": true,
              "quota_max": 300,
              "quota_remaining": 298
            }
    """
    
    func test_DataManagerUserParsing() {
        
        let network = SOMockNetworkManager(session: createSessionWithJson(validJsonString))
        
        let sut = SODataManager(networkManager: network)
        
        sut.getData(successBlock: { (users) in
            
            XCTAssertEqual(users.count, 1)
            XCTAssertEqual(users[0].name, "Mark Byers")
            
        }) { (error) in
            XCTFail()
        }
        
    }
    
    func test_DataManagerErrorParsing() {
                
        let network = SOMockNetworkManager(session: createSessionWithJson(""))
        
        let sut = SODataManager(networkManager: network)
        
        var errorRetrieved: SONetworkError?
        sut.getData(successBlock: { (users) in
            XCTFail()
        }) { (error) in
            errorRetrieved = error as? SONetworkError
            XCTAssertTrue(errorRetrieved! == .decodingFailed)
        }
        
    }
    
}

//MARK: - Helpers
extension SODataManagerTests {
    
    func createSessionWithJson(_ jsonString: String) -> SOMockNetworkSession {
        
        let mockSession = SOMockNetworkSession()
        let data = jsonString.data(using: .utf8)
        mockSession.data = data
        
        let url = URL(string: "url")!
        let mockResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        mockSession.response = mockResponse
        
        return mockSession
    }
    
}
