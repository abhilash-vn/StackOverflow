//
//  SOUserListViewPresenter.swift
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
        self.view?.showUserList(users: self.users!)
    }
    
    func showError(error: DisplayableError) {
        print("Show Error")
        
        self.view?.showError(errorMessage: error.message)
    }
    
}

extension SOUserListViewPresenter: UserListViewInteractionProtocol {

    // If we had to actually call a request to server, we should pass this to coordinator to act on it,
    // Coordinator should act on the data
    // Now we are simply updating the model here for simplicity
    
    func followActionRequested(on user: SOUserViewData, index: Int) {

        var storedUser = self.users?[index]
        storedUser!.isFollowing = !storedUser!.isFollowing
    }
    
    func blockingActionRequested(on user: SOUserViewData, index: Int) {

        var storedUser = self.users?[index]
        storedUser!.isBlocked = !storedUser!.isBlocked
    }
    
}
