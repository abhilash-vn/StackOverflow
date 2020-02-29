//
//  SOUserViewModel.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 29/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation


protocol SOUserViewData {
    
    var profileImageURL: String { get }
    var name: String { get }
    var reputation: Int { get }
    var isFollowing: Bool { get set }
    var isBlocked: Bool { get set }
    var isInExpandedState: Bool { get set }
}

class SOUserViewModel: SOUserViewData {
    
    let profileImageURL: String
    let name: String
    let reputation: Int
    
    var isFollowing: Bool = false
    var isBlocked: Bool = false
    var isInExpandedState: Bool = false
    
    func setFollowing(following: Bool) {
        isFollowing = following
    }
    
    func setBlocked(blocked: Bool) {
        isBlocked = blocked
    }
    
    func setisInExpandedState(state: Bool) {
        isInExpandedState = state
    }
    
    init(user: SOUser) {
        profileImageURL = user.profileImageURL
        name = user.name
        reputation = user.reputation
    }
}
