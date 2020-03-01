//
//  SODataParserTests.swift
//  StackOverflowTests
//
//  Created by Viswambharan Nikitha, Abhilash on 01/03/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import XCTest

@testable import StackOverflow

class SODataParserTests: XCTestCase {
    
    let sut = SODataParser()
    var errorRetrieved: SONetworkError?
    
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
    
    
    let invalidJSONString = """
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
                     "website_url": "http://careers.stackoverflow.com/markbyers/",
                     "link": "https://stackoverflow.com/users/61974/mark-byers",
                     "profile_image": "https://www.gravatar.com/avatar/ad240ed5cc406759f0fd72591dc8ca47?s=128&d=identicon&r=PG"
                   }
                 ],
                 "has_more": true,
                 "quota_max": 300,
                 "quota_remaining": 298
               }
       """
    
    func test_DataParsingValidJSONIsSuccess() {
        
        let validData = validJsonString.data(using: .utf8)

        do {
            let users = try sut.parseData(data: validData)
            
            XCTAssert(users.count == 1)
            XCTAssertEqual(users[0].name, "Mark Byers")
            
            XCTAssertEqual(users[0].profileImageURL, "https://www.gravatar.com/avatar/ad240ed5cc406759f0fd72591dc8ca47?s=128&d=identicon&r=PG")
            
            XCTAssertEqual(users[0].reputation, 649764)
            
        } catch {
            XCTFail()
        }
    }
    
    func test_DataParsingEmptyDataFails() {

        do {
            _ = try sut.parseData(data: nil)
        } catch let parsedError {
           errorRetrieved = parsedError as? SONetworkError
        }
        
        XCTAssertTrue(errorRetrieved! == .invalidData)
    }
    
    func test_DataParsingInvalidDataFails() {
        
        let invalidData = invalidJSONString.data(using: .utf8)

        do {
            _ = try sut.parseData(data: invalidData)
        } catch let parsedError {
           errorRetrieved = parsedError as? SONetworkError
        }
        
        XCTAssertTrue(errorRetrieved! == .decodingFailed)
    }
    
}
