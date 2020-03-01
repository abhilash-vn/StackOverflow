//
//  SOMainCoordinator.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 29/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation
import UIKit

class SOMainCoordinator: Coordinator {
    
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
            self.presenter.showError(error: error.localizedDescription)
        }
        
    }
    
}



