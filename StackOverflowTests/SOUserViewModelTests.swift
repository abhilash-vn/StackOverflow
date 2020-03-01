//
//  SOUserViewModelTests.swift
//  StackOverflowTests
//
//  Created by Viswambharan Nikitha, Abhilash on 01/03/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import XCTest
@testable import StackOverflow

class SOUserViewModelTests: XCTestCase {
    
    let networkUser = SOUserModel(profileImageURL: "url", name: "name", reputation: 12345)
    
    func test_userModelInitialisation() {
        
        let sut = SOUserViewModel(user: networkUser)
        XCTAssertEqual(sut.name, networkUser.name)
        XCTAssertEqual(sut.profileImageURL, networkUser.profileImageURL)
        XCTAssertEqual(sut.reputation, networkUser.reputation)
        
        XCTAssertFalse(sut.isBlocked)
        XCTAssertFalse(sut.isFollowing)
        XCTAssertFalse(sut.isInExpandedState)
    }

}
