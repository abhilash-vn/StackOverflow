//
//  SOPresenter.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 29/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation

class SOUserListViewPresenter : UserListViewPresenter {
    
    var users: [SOUserViewData]?
    
    weak var view: UserListView?
    
    required init(view: UserListView) {
        self.view = view
    }
    
    func updateUsersList(users: [SOUser]) {
        
        let userDatas = users.map({ (user) -> SOUserViewModel in
            SOUserViewModel(user: user)
        })
        
        self.users = userDatas
        
        DispatchQueue.main.async {
            self.view?.showUserList(users: self.users!)
        }
    }
    
    func showError(error: String) {
        print("Show Error")
        
        DispatchQueue.main.async {
            self.view?.showError(errorTitle: "nil", errorMessage: error)
        }
        
    }
    
}

extension SOUserListViewPresenter: UserListViewInteractionProtocol {
    
    func followRequested(on user: SOUserViewData, shouldFollow: Bool) {
        print("followRequested")
    }
    
    func blockingRequested(on user: SOUserViewData, shouldBlock: Bool) {
        print("blockingRequested")
    }
    
}
