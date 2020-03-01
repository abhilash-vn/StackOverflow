//
//  SOMainCoordinator.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 29/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation
import UIKit

class SOMainCoordinator: SOCoordinator {
    
    init(viewController: UIViewController) {
        rootViewController = viewController
    }
    
    /// Various dependencies for usage and injection.
    private var presenter: UserListViewPresenter!
    private lazy var networkManager: NetworkService = SONetworkManager()
    private lazy var dataManager: SODataManager = SODataManager(networkManager: networkManager)
    
    let rootViewController: UIViewController
    
    func start() {
        
        guard let view = rootViewController as? UserListView else {
            fatalError("The coordinator is starting with an incompatible root view")
        }
        
        presenter = SOUserListViewPresenter(view: view)
        
        dataManager.getData(successBlock: { (users) in
            
            self.presenter.updateUsersList(users: users)
            
        }) { (error) in
            
            var userFriendlyError = SODisplayableError(message: "Something went wrong! Please try after sometime")
            
            if let networkError = error as? SONetworkError {
                userFriendlyError = SODisplayableError(error: networkError)
            }
            
            self.presenter.showError(error: userFriendlyError)
        }
        
    }
    
}



