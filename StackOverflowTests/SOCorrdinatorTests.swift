//
//  SOCorrdinatorTests.swift
//  StackOverflowTests
//
//  Created by Viswambharan Nikitha, Abhilash on 01/03/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import XCTest

@testable import StackOverflow

class SOMockDataManager: DataService {
    
    var users: [SOUser]? = nil
    var error: SONetworkError? = nil
    
    private let networkManager: SOMockNetworkManager
    
    required init(networkManager: NetworkService) {
        self.networkManager = networkManager as! SOMockNetworkManager
    }
    
    func getData(successBlock: @escaping ([SOUser]) -> (), failedBlock: @escaping SOMockDataManager.failure) {
        
        networkManager.fetchData(from: "url") { (data, response, error) in
            if let datas = data {
                let users = try! SODataParser().parseData(data: datas)
                successBlock(users)
                self.users = users
                return
            }
            
            if let errors = error as? SONetworkError {
                failedBlock(errors)
                self.error = errors
            }
        }
    }
}

class SOCorrdinatorTests: XCTestCase {
    
    var mainvc: SOTableListViewController!
      
    private func setUpViewControllers() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.mainvc = storyboard.instantiateViewController(withIdentifier: "MainVC") as? SOTableListViewController
        _ = self.mainvc.view
        
    }

    func test_coordinatorInitialisation() {
        
        setUpViewControllers()
        
        let sut = SOMainCoordinator(viewController: self.mainvc)
        XCTAssertNotNil(sut.rootViewController)
    }
    
    func test_coordinatorStartAndFetchesData() {
        
        setUpViewControllers()
        
        let sut = SOMainCoordinator(viewController: self.mainvc)
        
        let session = SODataManagerTests().createSessionWithJson(SODataManagerTests().validJsonString)
        let networkService = SOMockNetworkManager(session: session)
        
        let dataManager = SOMockDataManager(networkManager: networkService)
        sut.start(dataManager: dataManager)
        
        XCTAssertNotNil(dataManager.users)
    }
    
    func test_coordinatorStartsAndFetchesError() {
        
        setUpViewControllers()
        
        let sut = SOMainCoordinator(viewController: self.mainvc)
                
        let session = SOMockNetworkSession()
        session.error = SONetworkError.networkConnection
        
        let networkService = SOMockNetworkManager(session: session)
        
        let dataManager = SOMockDataManager(networkManager: networkService)
        sut.start(dataManager: dataManager)
        
        XCTAssertNil(dataManager.users)
        XCTAssertNotNil(dataManager.error)
    }
    
    func test_coordinatorStop() {
        
        setUpViewControllers()
        
        let sut = SOMainCoordinator(viewController: self.mainvc)
        
        sut.stop()
        
        XCTAssertNil(sut.rootViewController)
    }

}
