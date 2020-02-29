//
//  SOUserViewModel.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 29/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation


protocol SOUserViewData {
    
    var profileImage: String { get }
    var name: String { get }
    var reputation: Int { get }
    var isFollowing: Bool { get set }
    var isBlocked: Bool { get set }
    var isInExpandedState: Bool { get set }
}

struct SOUserViewModel: SOUserViewData {
    
    let profileImage: String
    let name: String
    let reputation: Int
    
    var isFollowing: Bool = false
    var isBlocked: Bool = false
    var isInExpandedState: Bool = false
    
    mutating func setFollowing(following: Bool) {
        isFollowing = following
    }
    
    mutating func setBlocked(blocked: Bool) {
        isBlocked = blocked
    }
    
    mutating func setisInExpandedState(state: Bool) {
        isInExpandedState = state
    }
    
    init(user: SOUser) {
        profileImage = user.profileImage
        name = user.name
        reputation = user.reputation
        
    }
}
