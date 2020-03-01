//
//  DataManager.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//


import Foundation

/// The data  service. Any object wanting to provide data to app should conform to this.
/// Conform to this when you want to create a real or mock data service.
protocol DataService {
    
    associatedtype Model
    
    typealias success = (Model)->()
    typealias failure = (Error)->()
    
    init(networkManager: NetworkService)
    
    func getData(successBlock: @escaping success, failedBlock: @escaping failure)
}


/// The real data maanager for the app. Will use network service to supply data.
struct SODataManager: DataService {
    
    typealias Model = [SOUser]
    
    private let networkManager: NetworkService
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    func getData(successBlock: @escaping success, failedBlock: @escaping failure) {
        
        let baseURLString = SOConfiguration.baseURLString
        
        print("🅿️ URL created : \(baseURLString)")
            
        networkManager.fetchData(from: baseURLString) { (data, response, error) in
            
            do {
                
                if let printable = data?.prettyPrintedJSONString {
                    print("Data: \(printable)")
                      
                }
                
                try SOErrorParser().parseError(error: error)
                try SOResponseParser().parseResponse(response: response)
                let users = try SODataParser().parseData(data: data)
                
                successBlock(users)
                
            } catch let error {
                
                print("Caught error: \(error)")
                failedBlock(error)
            }
        }
    }
}


