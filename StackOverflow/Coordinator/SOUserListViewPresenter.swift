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
    
    func updateUsersList(users: [SOUserViewData]) {
        self.users = users
        self.view?.showUserList(users: self.users!)
    }
    
    func showError(error: String) {
        print("Show Error")
        self.view?.showError(errorTitle: <#T##String#>, errorMessage: <#T##String#>)
    }
    
}
