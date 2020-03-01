//
//  SODataParser.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import Foundation

protocol DataParsingService {
    
    /// The model that will be the output
    associatedtype Model
    
    /// Parse the data to return proper model
    /// - Parameter data: The data from network
    func parseData(data: Data?) throws ->  Model
}

struct SODataParser: DataParsingService {
    
    typealias Model = [SOUser]
    
    func parseData(data: Data?) throws ->  [SOUser] {
        
        guard let data = data else {
            throw SONetworkError.invalidData
        }
        
        do {
            let usersServiceData = try JSONDecoder().decode(SOUsersModelService.self, from: data)
            return usersServiceData.users
        } catch let error {
            
            print("Parsing Error: \(error)")
            throw SONetworkError.decodingFailed
        }
        
    }
    
}
