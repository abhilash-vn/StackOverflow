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
        view.actionDelegate = self
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

    func followActionRequested(on user: SOUserViewData, index: Int) {
        
        var storedUser = self.users?[index]
        storedUser!.isFollowing = !storedUser!.isFollowing
        
        print("followRequested")
    }
    
    func blockingActionRequested(on user: SOUserViewData, index: Int) {
        
        var storedUser = self.users?[index]
        storedUser!.isBlocked = !storedUser!.isBlocked
        
        print("blockingRequested")
    }
    
}
