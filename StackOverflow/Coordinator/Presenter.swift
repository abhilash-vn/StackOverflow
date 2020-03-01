//
//  Presenter.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 29/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation

/// The intercation from view, any object that wants to handle user interaction should conform to this.
protocol UserListViewInteractionProtocol: AnyObject {
    
    func followActionRequested(on user: SOUserViewData, index: Int)
    
    func blockingActionRequested(on user: SOUserViewData, index: Int)
}

/// Any object that wants to act as view to show user list needs to conform to this protocol
protocol UserListView: AnyObject {
    
    /// Delegate to capture and handle the user interaction inside the view.
    var actionDelegate: UserListViewInteractionProtocol! { get set }
    
    /// Show the list of user
    /// - Parameter users: The user objects that should be listed
    func showUserList(users: [SOUserViewData])
    
    /// Displays error to user.
    /// - Parameters:
    ///   - errorMessage: The error message to be presented.
    func showError(errorMessage: String)

}

/// Any object that wants to act as view presenter should conform to this protocol.
protocol UserListViewPresenter: AnyObject {
    
    /// Initialise with proper view to be presented
    /// - Parameter view: The view that will be presented to the  user.
    init(view: UserListView)
    
    func updateUsersList(users: [SOUser])
    
    /// Shows an error in the set view
    /// - Parameter error: The error object that contains the message that will be dispayed.
    func showError( error: DisplayableError)
}



