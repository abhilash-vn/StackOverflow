//
//  SOUserListViewPresenterTests.swift
//  StackOverflowTests
//
//  Created by Viswambharan Nikitha, Abhilash on 01/03/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import XCTest

@testable import StackOverflow

class MockUserListView: UserListView {
    
    var users: [SOUserViewData]? = nil
    var error: String? = nil
    
    var actionDelegate: UserListViewInteractionProtocol!
    
    func showUserList(users: [SOUserViewData]) {
        self.users = users
    }
    
    func showError(errorMessage: String) {
        self.error = errorMessage
    }
    
}

class SOUserListViewPresenterTests: XCTestCase {
    
    let view = MockUserListView()
    let user1 = SOUserModel(profileImageURL: "image1", name: "test1", reputation: 12)
    let user2 = SOUserModel(profileImageURL: "image2", name: "test1", reputation: 100)
    
    func test_PresenterUpdatingUsersList() {

        let users = [user1, user2]
        
        let sut = SOUserListViewPresenter(view: view)
        sut.updateUsersList(users: users)
        
        XCTAssertNotNil(sut.view)
        
        XCTAssertEqual(view.users?.count, users.count)
        XCTAssertEqual(view.users?[0].name, user1.name)
        XCTAssertEqual(view.users?[1].name, user2.name)
        
        
    }
    
    func test_PresenterShowingError() {
        
        let error = SODisplayableError(message: "ErrorToDisplay")
        
        let sut = SOUserListViewPresenter(view: view)
        sut.showError(error: error)

        XCTAssertEqual(view.error, error.message)
        
    }
    
    func test_PresenterFollowRequestedOnUser() {

        let users = [user1]
        
        let sut = SOUserListViewPresenter(view: view)
        sut.updateUsersList(users: users)
        
        if let storedUser = sut.users?[0] {
            
            sut.followActionRequested(on: storedUser, index: 0)
            XCTAssert(storedUser.isFollowing == true)
            
        } else { XCTFail() }
    }
    
    
    func test_PresenterBlockRequestedOnUser() {

        let users = [user1]
        
        let sut = SOUserListViewPresenter(view: view)
        sut.updateUsersList(users: users)
        
        if let storedUser = sut.users?[0] {
            
            sut.blockingActionRequested(on: storedUser, index: 0)
            XCTAssert(storedUser.isBlocked == true)
            
        } else { XCTFail() }
    }


}
