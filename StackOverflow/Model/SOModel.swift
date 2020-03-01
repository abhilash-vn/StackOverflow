//
//  SOModel.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation

protocol SOUser {
    var profileImageURL: String { get }
    var name: String { get }
    var reputation: Int { get }
}

struct SOUsersModelService: Decodable {
    
    let users: [SOUserModel]
    
   
    enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}

struct SOUserModel: SOUser, Codable {

    let profileImageURL: String
    let name: String
    let reputation: Int

    enum CodingKeys: String, CodingKey {
        case profileImageURL = "profile_image"
        case name = "display_name"
        case reputation
    }
}

/*
 
 {
 "items": [
   {
     "badge_counts": {
       "bronze": 8701,
       "silver": 8365,
       "gold": 743
     },
     "account_id": 11683,
     "is_employee": false,
     "last_modified_date": 1582668325,
     "last_access_date": 1582836897,
     "reputation_change_year": 12093,
     "reputation_change_quarter": 12093,
     "reputation_change_month": 5615,
     "reputation_change_week": 1065,
     "reputation_change_day": 215,
     "reputation": 1166215,
     "creation_date": 1222430705,
     "user_type": "registered",
     "user_id": 22656,
     "accept_rate": 86,
     "location": "Reading, United Kingdom",
     "website_url": "http://csharpindepth.com",
     "link": "https://stackoverflow.com/users/22656/jon-skeet",
     "profile_image": "https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=128&d=identicon&r=PG",
     "display_name": "Jon Skeet"
   },
 
 
 */
